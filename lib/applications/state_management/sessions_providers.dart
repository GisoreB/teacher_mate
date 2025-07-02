import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/database_provider.dart';
import 'package:teacher_mate/domain/data_models/upcoming_session_data_model.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:drift/drift.dart';
import 'package:teacher_mate/infrastructure/data/session_status.dart';

part 'sessions_providers.g.dart';

@riverpod
Stream<List<Session>> sessionsByClass(Ref ref, int classId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.sessions)
    ..where((s) => s.classId.equals(classId))).watch();
}

@riverpod
Stream<Session> singleSession(Ref ref, int sessionId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.sessions)
    ..where((c) => c.id.equals(sessionId))).watchSingle();
}

@riverpod
Stream<List<UpcomingSessionData>> upcomingSessions(Ref ref) {
  final sessionRepo = ref.watch(sessionRepositoryProvider.notifier);
  return sessionRepo.watchEarliestScheduledSessionsWithClass();
}

@riverpod
class SessionRepository extends _$SessionRepository {
  @override
  AppDatabase build() => ref.watch(databaseProvider);

  Future<int> insert(SessionsCompanion data) =>
      state.into(state.sessions).insert(data);

  Future<bool> update(Session data) =>
      state.update(state.sessions).replace(data);

  Future<int> delete(int sessionId) {
    return (state.delete(state.sessions)
      ..where((tbl) => tbl.id.equals(sessionId))).go();
  }

  Future<int> updateStatus(int sessionId, SessionStatus newStatus) {
    return (state.update(state.sessions)..where(
      (tbl) => tbl.id.equals(sessionId),
    )).write(SessionsCompanion(status: Value(newStatus)));
  }

  Future<int> updateNote(int sessionId, String note) {
    return (state.update(state.sessions)..where(
      (tbl) => tbl.id.equals(sessionId),
    )).write(SessionsCompanion(note: Value(note)));
  }

  Future<int> updateHomework(int sessionId, String homework) {
    return (state.update(state.sessions)..where(
      (tbl) => tbl.id.equals(sessionId),
    )).write(SessionsCompanion(homework: Value(homework)));
  }

  Future<int> updateDate(int sessionId, DateTime date) {
    return (state.update(state.sessions)..where(
      (tbl) => tbl.id.equals(sessionId),
    )).write(SessionsCompanion(date: Value(date)));
  }

  Future<int?> getLastSessionNumber(int classId) async {
    final lastSession =
        await (state.select(state.sessions)
              ..where((s) => s.classId.equals(classId))
              ..orderBy([(s) => OrderingTerm.desc(s.number)])
              ..limit(1))
            .getSingleOrNull();
    if (lastSession != null) {
      return lastSession.number;
    }
    return null;
  }

  Future<int> getScheduledSessionsCountForClass(int classId) async {
    final sessionsStream =
        (state.select(state.sessions)..where(
          (s) =>
              s.classId.equals(classId) &
              s.status.equals(SessionStatus.scheduled.name),
        )).watch();

    final sessions = await sessionsStream.first;
    return sessions.length;
  }

  Stream<List<UpcomingSessionData>> watchEarliestScheduledSessionsWithClass() {
    final db = state;

    final activeClassIdsStream = db.select(db.classes).watch().map((
      allClasses,
    ) {
      final activeClasses = allClasses.where((c) => c.isActive).toList();
      return activeClasses.map((c) => c.id).toList();
    });

    return activeClassIdsStream.asyncExpand<List<UpcomingSessionData>>((
      activeClassIds,
    ) {
      if (activeClassIds.isEmpty) {
        return Stream.value(<UpcomingSessionData>[]);
      }

      final now = DateTime.now();
      final todayDate = DateTime(now.year, now.month, now.day);
      final query =
          db.select(db.sessions).join([
              innerJoin(
                db.classes,
                db.classes.id.equalsExp(db.sessions.classId),
              ),
            ])
            ..where(
              db.sessions.classId.isIn(activeClassIds) &
                  db.sessions.date.isBiggerOrEqualValue(todayDate) &
                  db.sessions.status.equals(SessionStatus.scheduled.name),
            )
            ..orderBy([OrderingTerm.asc(db.sessions.date)])
            ..limit(5);

      return query
          .watch()
          .map<List<UpcomingSessionData>>((resultRows) {
            if (resultRows.isNotEmpty) {
              final upcomingSessions =
                  resultRows.map((row) {
                    final session = row.readTable(db.sessions);
                    final classData = row.readTable(db.classes);
                    return UpcomingSessionData(
                      session: session,
                      classData: classData,
                    );
                  }).toList();
              return upcomingSessions;
            }
            return <UpcomingSessionData>[];
          })
          .handleError((error, stackTrace) {
            return <UpcomingSessionData>[];
          });
    });
  }
}

@riverpod
Stream<int> scheduledSessionsCount(Ref ref, int classId) {
  final db = ref.watch(databaseProvider);

  return (db.select(db.sessions)..where(
    (s) =>
        s.classId.equals(classId) &
        s.status.equals(SessionStatus.scheduled.name),
  )).watch().map((list) => list.length);
}

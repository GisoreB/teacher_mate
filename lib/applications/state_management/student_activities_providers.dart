import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/database_provider.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';

part 'student_activities_providers.g.dart';

@riverpod
Stream<List<StudentActivity>> activitiesForSession(Ref ref, int sessionId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.studentActivities)
    ..where((a) => a.sessionId.equals(sessionId))).watch();
}

@riverpod
Stream<List<StudentActivity>> activitiesForStudent(Ref ref, int studentId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.studentActivities)
    ..where((sa) => sa.studentId.equals(studentId))).watch();
}

@riverpod
class StudentActivityRepository extends _$StudentActivityRepository {
  @override
  AppDatabase build() => ref.watch(databaseProvider);

  Future<int> insert(StudentActivitiesCompanion data) =>
      state.into(state.studentActivities).insert(data);

  Future<bool> update(StudentActivity data) =>
      state.update(state.studentActivities).replace(data);

  Future<int> delete(int id) =>
      (state.delete(state.studentActivities)
        ..where((tbl) => tbl.id.equals(id))).go();

  Future<StudentActivity?> _find(int studentId, int sessionId) async {
    return (await (state.select(state.studentActivities)..where(
      (tbl) =>
          tbl.studentId.equals(studentId) & tbl.sessionId.equals(sessionId),
    )).getSingleOrNull());
  }

  Future<void> setAttendance(int studentId, int sessionId, bool value) async {
    final existing = await _find(studentId, sessionId);
    if (existing != null) {
      await update(existing.copyWith(attendance: value));
    } else {
      await insert(
        StudentActivitiesCompanion.insert(
          studentId: studentId,
          sessionId: sessionId,
          attendance: Value(value),
        ),
      );
    }
  }

  Future<void> setHomework(int studentId, int sessionId, bool value) async {
    final existing = await _find(studentId, sessionId);
    if (existing != null) {
      await update(existing.copyWith(homework: value));
    } else {
      await insert(
        StudentActivitiesCompanion.insert(
          studentId: studentId,
          sessionId: sessionId,
          homework: Value(value),
        ),
      );
    }
  }

  Future<void> setClassActivity(
    int studentId,
    int sessionId,
    bool value,
  ) async {
    final existing = await _find(studentId, sessionId);
    if (existing != null) {
      await update(existing.copyWith(classActivity: value));
    } else {
      await insert(
        StudentActivitiesCompanion.insert(
          studentId: studentId,
          sessionId: sessionId,
          classActivity: Value(value),
        ),
      );
    }
  }
}

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/database_provider.dart';
import 'package:teacher_mate/domain/data_models/upcoming_quiz_data_model.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';

part 'quizzes_providers.g.dart';

@riverpod
Stream<List<Quiz>> quizzesByClass(Ref ref, int classId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quizzes)
    ..where((q) => q.classId.equals(classId))).watch();
}

@riverpod
Stream<List<Quiz>> allQuizzes(Ref ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.quizzes).watch();
}

@riverpod
Stream<Quiz> singleQuiz(Ref ref, int quizId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quizzes)
    ..where((tbl) => tbl.id.equals(quizId))).watchSingle();
}

@riverpod
Stream<List<UpcomingQuizData>> upcomingQuizzes(Ref ref) {
  final sessionRepo = ref.watch(quizRepositoryProvider.notifier);
  return sessionRepo.watchUpcomingQuizzesWithClass();
}

@riverpod
class QuizRepository extends _$QuizRepository {
  @override
  AppDatabase build() => ref.watch(databaseProvider);

  Future<int> insert(QuizzesCompanion data) =>
      state.into(state.quizzes).insert(data);

  Future<bool> update(Quiz data) => state.update(state.quizzes).replace(data);

  Future<int> delete(int id) =>
      (state.delete(state.quizzes)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> updateDescription(int quizId, String description) {
    return (state.update(state.quizzes)..where(
      (q) => q.id.equals(quizId),
    )).write(QuizzesCompanion(description: Value(description)));
  }

  Future<int> updateMaxScore(int quizId, String maxScore) {
    return (state.update(state.quizzes)..where(
          (q) => q.id.equals(quizId),
    )).write(QuizzesCompanion(maxScore: Value(int.tryParse(maxScore))));
  }

  Future<int> updateDate(int quizId, DateTime date) {
    return (state.update(state.quizzes)..where(
      (q) => q.id.equals(quizId),
    )).write(QuizzesCompanion(date: Value(date)));
  }

  Stream<List<UpcomingQuizData>> watchUpcomingQuizzesWithClass() {
    final db = state;

    final activeClassIdsStream = db.select(db.classes).watch().map((
      allClasses,
    ) {
      final activeClasses = allClasses.where((c) => c.isActive).toList();
      return activeClasses.map((c) => c.id).toList();
    });

    return activeClassIdsStream.asyncExpand<List<UpcomingQuizData>>((
      activeClassIds,
    ) {
      if (activeClassIds.isEmpty) {
        return Stream.value(<UpcomingQuizData>[]);
      }

      final now = DateTime.now();
      final todayDate = DateTime(now.year, now.month, now.day);

      final query =
          db.select(db.quizzes).join([
              innerJoin(
                db.classes,
                db.classes.id.equalsExp(db.quizzes.classId),
              ),
            ])
            ..where(
              db.quizzes.classId.isIn(activeClassIds) &
                  db.quizzes.date.isBiggerOrEqualValue(todayDate),
            )
            ..orderBy([OrderingTerm.asc(db.quizzes.date)])
            ..limit(5);
      return query
          .watch()
          .map<List<UpcomingQuizData>>((resultRows) {
            if (resultRows.isNotEmpty) {
              final upcomingQuizzes =
                  resultRows.map((row) {
                    final quiz = row.readTable(db.quizzes);
                    final classData = row.readTable(db.classes);
                    return UpcomingQuizData(quiz: quiz, classData: classData);
                  }).toList();
              return upcomingQuizzes;
            }
            return <UpcomingQuizData>[];
          })
          .handleError((error, stackTrace) {
            return <UpcomingQuizData>[];
          });
    });
  }
}

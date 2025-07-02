import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/database_provider.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';

part 'quiz_results_providers.g.dart';

@riverpod
Stream<List<QuizResult>> resultsByQuiz(Ref ref, int quizId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quizResults)
    ..where((q) => q.quizId.equals(quizId))).watch();
}

@riverpod
Stream<List<QuizResult>> quizResultsForStudent(Ref ref, int studentId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.quizResults)
    ..where((a) => a.studentId.equals(studentId))).watch();
}
@riverpod
class QuizResultRepository extends _$QuizResultRepository {
  @override
  AppDatabase build() => ref.watch(databaseProvider);

  Future<int> insert(QuizResultsCompanion data) =>
      state.into(state.quizResults).insert(data);

  Future<bool> update(QuizResult data) =>
      state.update(state.quizResults).replace(data);

  Future<int> delete(int id) =>
      (state.delete(state.quizResults)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> upsertResult({required QuizResultsCompanion companion}) async {
    final quizId = companion.quizId.value;
    final studentId = companion.studentId.value;
    final score = companion.score.value;
    final existingResult =
        await (state.select(state.quizResults)..where(
          (tbl) => tbl.quizId.equals(quizId) & tbl.studentId.equals(studentId),
        )).getSingleOrNull();
    if (existingResult != null) {
      final updateCompanion = QuizResultsCompanion(score: Value(score));
      await (state.update(state.quizResults)..where(
        (tbl) => tbl.id.equals(existingResult.id),
      )).write(updateCompanion);
    } else {
      await insert(companion);
    }
  }
}

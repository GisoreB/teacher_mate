import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'classes_providers.g.dart';

@riverpod
Stream<List<Class>> allClasses(Ref ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.classes).watch();
}

@riverpod
Stream<Class> singleClass(Ref ref, int classId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.classes)
    ..where((c) => c.id.equals(classId))).watchSingle();
}

@riverpod
class ClassRepository extends _$ClassRepository {
  @override
  AppDatabase build() => ref.watch(databaseProvider);

  Future<int> insertClass(ClassesCompanion entry) {
    return state.into(state.classes).insert(entry);
  }

  Future<int> updateClass(int classId, ClassesCompanion updated) {
    return (state.update(state.classes)
      ..where((tbl) => tbl.id.equals(classId))).write(updated);
  }

  Future<int> deleteClass(int id) {
    return (state.delete(state.classes)..where((c) => c.id.equals(id))).go();
  }

  Future<int> updateSyllabus(int classId, String syllabus) {
    return (state.update(state.classes)..where(
      (tbl) => tbl.id.equals(classId),
    )).write(ClassesCompanion(syllabus: Value(syllabus)));
  }

  Future<int> updateIsActive(int classId, bool isActive) {
    return (state.update(state.classes)..where(
      (tbl) => tbl.id.equals(classId),
    )).write(ClassesCompanion(isActive: Value(isActive)));
  }

  Future<int> updateSessionCount(int classId, int count) async {
    final currentClass =
        await (state.select(state.classes)
          ..where((tbl) => tbl.id.equals(classId))).getSingleOrNull();

    if (currentClass == null) return 0;

    return (state.update(state.classes)
      ..where((tbl) => tbl.id.equals(classId))).write(
      ClassesCompanion(sessionCount: Value(currentClass.sessionCount + count)),
    );
  }

  Future<void> deleteClassWithRelations(int classId) async {
    await state.transaction(() async {
      await (state.delete(state.students)
        ..where((tbl) => tbl.classId.equals(classId)))
          .go();

      await (state.delete(state.quizzes)
        ..where((tbl) => tbl.classId.equals(classId)))
          .go();

      await (state.delete(state.sessions)
        ..where((tbl) => tbl.classId.equals(classId)))
          .go();

      await (state.delete(state.classes)
        ..where((tbl) => tbl.id.equals(classId)))
          .go();
    });
  }
}

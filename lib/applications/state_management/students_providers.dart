import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/database_provider.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';

part 'students_providers.g.dart';

@riverpod
Stream<List<Student>> studentsByClass(Ref ref, int classId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.students)
    ..where((s) => s.classId.equals(classId))).watch();
}

@riverpod
Stream<Student> singleStudent(Ref ref, int studentId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.students)..where((s) => s.id.equals(studentId))).watchSingle();
}

@riverpod
class StudentRepository extends _$StudentRepository {
  @override
  AppDatabase build() => ref.watch(databaseProvider);

  Future<int> insertStudent(StudentsCompanion entry) {
    return state.into(state.students).insert(entry);
  }

  Future<bool> updateStudent(Student updated) {
    return state.update(state.students).replace(updated);
  }

  Future<int> deleteStudent(int id) {
    return (state.delete(state.students)..where((s) => s.id.equals(id))).go();
  }

  Future<int> updateNote(int studentId, String? newNote) async {
    return (state.update(state.students)..where((s) => s.id.equals(studentId)))
        .write(StudentsCompanion(note: Value(newNote)));
  }
  Future<int> updateAge(int studentId, int? newAge) async {
    return (state.update(state.students)..where((s) => s.id.equals(studentId)))
        .write(StudentsCompanion(age: Value(newAge)));
  }
  Future<int> updateBackground(int studentId, String? newBackground) async {
    return (state.update(state.students)..where((s) => s.id.equals(studentId)))
        .write(StudentsCompanion(background: Value(newBackground)));
  }
}

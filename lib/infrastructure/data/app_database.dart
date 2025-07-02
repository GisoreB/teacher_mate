import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teacher_mate/infrastructure/data/session_status.dart';

part 'app_database.g.dart'; // For code generation

@DataClassName('Class')
class Classes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get description => text().nullable()();

  IntColumn get duration => integer()();

  DateTimeColumn get firstSession => dateTime()();

  IntColumn get sessionCount => integer()();

  BoolColumn get isActive => boolean().withDefault(Constant(true))();

  TextColumn get syllabus => text().nullable()();
}

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get classId => integer().references(Classes, #id)();

  TextColumn get name => text()();

  TextColumn get note => text().nullable()();

  // Add new column nullable, fot migrate v2
  IntColumn get age => integer().nullable()();

  TextColumn get background => text().nullable()();
}

class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get classId => integer().references(Classes, #id)();

  IntColumn get number => integer()();

  DateTimeColumn get date => dateTime()();

  TextColumn get status =>
      text()
          .withDefault(Constant(SessionStatus.scheduled.name))
          .map(const SessionStatusConverter())();

  TextColumn get homework => text().nullable()();

  TextColumn get note => text().nullable()();
}

@DataClassName('Quiz')
class Quizzes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get classId => integer().references(Classes, #id)();

  TextColumn get title => text()();

  DateTimeColumn get date => dateTime()();

  IntColumn get maxScore => integer().nullable()();

  TextColumn get description => text().nullable()();
}

// @DataClassName('StudentActivity')
class StudentActivities extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get studentId => integer().references(Students, #id)();

  IntColumn get sessionId => integer().references(Sessions, #id)();

  BoolColumn get attendance => boolean().withDefault(Constant(false))();

  BoolColumn get homework => boolean().withDefault(Constant(false))();

  BoolColumn get classActivity => boolean().withDefault(Constant(false))();
}

class QuizResults extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get studentId => integer().references(Students, #id)();

  IntColumn get quizId => integer().references(Quizzes, #id)();

  RealColumn get score => real()();
}

@DriftDatabase(
  tables: [
    Classes,
    Students,
    Sessions,
    Quizzes,
    StudentActivities,
    QuizResults,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'tm_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(students, students.age);
        await migrator.addColumn(students, students.background);
      }
    },
  );
}

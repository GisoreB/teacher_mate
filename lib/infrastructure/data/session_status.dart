import 'package:drift/drift.dart';

enum SessionStatus {
  scheduled,
  completed,
  cancelled,
  substitute
}

class SessionStatusConverter extends TypeConverter<SessionStatus, String> {
  const SessionStatusConverter();

  @override
  SessionStatus fromSql(String fromDb) {
    return SessionStatus.values.firstWhere(
          (e) => e.name == fromDb,
      orElse: () => SessionStatus.scheduled,
    );
  }

  @override
  String toSql(SessionStatus value) => value.name;
}
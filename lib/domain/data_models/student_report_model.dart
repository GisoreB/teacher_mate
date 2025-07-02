import 'package:teacher_mate/domain/data_models/quiz_with_result_model.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';

class StudentReport {
  final Student student;
  final int attendanceCount;
  final int homeworkCount;
  final int activityCount;
  final List<QuizWithResult> quizzes;

  StudentReport({
    required this.student,
    required this.attendanceCount,
    required this.homeworkCount,
    required this.activityCount,
    required this.quizzes,
  });
}

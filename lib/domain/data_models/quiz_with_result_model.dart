import 'package:teacher_mate/infrastructure/data/app_database.dart';

class QuizWithResult {
  final Quiz quiz;
  final QuizResult result;
  QuizWithResult({required this.quiz, required this.result});
}
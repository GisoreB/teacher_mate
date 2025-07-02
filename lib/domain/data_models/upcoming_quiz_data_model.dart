import 'package:teacher_mate/infrastructure/data/app_database.dart';

class UpcomingQuizData {
  final Quiz quiz;
  final Class classData;
  UpcomingQuizData({required this.quiz, required this.classData});
}
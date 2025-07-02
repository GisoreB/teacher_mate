import 'package:go_router/go_router.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/presentation/screens/add_class_screen.dart';
import 'package:teacher_mate/presentation/screens/add_quiz_screen.dart';
import 'package:teacher_mate/presentation/screens/add_session_screen.dart';
import 'package:teacher_mate/presentation/screens/add_student_screen.dart';
import 'package:teacher_mate/presentation/screens/class_detail_screen.dart';
import 'package:teacher_mate/presentation/screens/edit_class_screen.dart';
import 'package:teacher_mate/presentation/screens/home_screen.dart';
import 'package:teacher_mate/presentation/screens/quiz_detail_screen.dart';
import 'package:teacher_mate/presentation/screens/session_detail_screen.dart';
import 'package:teacher_mate/presentation/screens/settings_screen.dart';
import 'package:teacher_mate/presentation/screens/student_detail_screen.dart';

class AppRouter {

  static final GoRouter router = GoRouter(
    initialLocation: Routes.homePath,
    routes: <RouteBase>[
      GoRoute(
        name: Routes.home,
        path: Routes.homePath,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.settingsPath,
        name: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: Routes.addClass,
        path: Routes.addClassPath,
        builder: (context, state) => const AddClassScreen(),
      ),
      GoRoute(
        path: Routes.classDetailPath,
        name: Routes.classDetail,
        builder: (context, state) {
          final classId = int.parse(state.pathParameters['classId']!);
          return ClassDetailScreen(classId: classId);
        },
      ),
      GoRoute(
        path: Routes.sessionDetailPath,
        name: Routes.sessionDetail,
        builder: (context, state) {
          final sessionId = int.parse(state.pathParameters['sessionId']!);
          return SessionDetailScreen(sessionId: sessionId);
        },
      ),
      GoRoute(
        path: Routes.quizDetailPath,
        name: Routes.quizDetail,
        builder: (context, state) {
          final quizId = int.parse(state.pathParameters['quizId']!);
          return QuizDetailScreen(quizId: quizId);
        },
      ),
      GoRoute(
        name: Routes.studentDetail, // Define Routes.studentDetail in router_consts.dart
        path: Routes.studentDetailPath,
        builder: (context, state) {
          final studentId = int.parse(state.pathParameters['studentId']!);
          return StudentDetailScreen(studentId: studentId);
        },
      ),
      GoRoute(
        path: Routes.addStudentPath,
        name: Routes.addStudent,
        builder: (context, state) {
          final classId = int.parse(state.pathParameters['classId']!);
          return AddStudentScreen(classId: classId);
        },
      ),
      GoRoute(
        path: Routes.addSessionPath,
        name: Routes.addSession,
        builder: (context, state) {
          final classId = int.parse(state.pathParameters['classId']!);
          return AddSessionScreen(classId: classId);
        },
      ),
      GoRoute(
        path: Routes.addQuizPath,
        name: Routes.addQuiz,
        builder: (context, state) {
          final classId = int.parse(state.pathParameters['classId']!);
          return AddQuizScreen(classId: classId);
        },
      ),
      GoRoute(
        path: Routes.editClassPath,
        name: Routes.editClass,
        builder: (context, state) {
          final classId = int.parse(state.pathParameters['classId']!);
          return EditClassScreen(classId: classId);
        },
      ),
    ],
  );
}

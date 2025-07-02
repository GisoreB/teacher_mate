class Routes {
  // --- Route Names ---
  static const String home = 'home';
  static const String settings = 'settings';
  static const String addClass = 'addClass';
  static const String addStudent = 'addStudent';
  static const String addSession = 'addSession';
  static const String addQuiz = 'addQuiz';
  static const String editClass = 'editClass';
  static const String classDetail = 'classDetail';
  static const String studentDetail = 'studentDetail';
  static const String sessionDetail = 'sessionDetail';
  static const String quizDetail = "quizDetail";

  // --- Route Paths ---
  static const String homePath = '/home';
  static const String settingsPath = '/settings';
  static const String addClassPath = '/addClass';
  static const String addStudentPath = '/addStudent/:classId';
  static const String addSessionPath = '/addSession/:classId';
  static const String addQuizPath = '/addQuiz/:classId';
  static const String editClassPath = '/class/edit/:classId';
  static const String classDetailPath = '/class/detail/:classId';
  static const String studentDetailPath = '/student/detail/:studentId';
  static const String sessionDetailPath = '/session/detail/:sessionId';
  static const String quizDetailPath = "/quiz/detail/:quizId";

}

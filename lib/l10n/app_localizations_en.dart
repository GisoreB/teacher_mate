// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String themeMode(String theme_mode) {
    String _temp0 = intl.Intl.selectLogic(theme_mode, {
      'dark': 'Dark',
      'light': 'Light',
      'system': 'System Default',
      'other': 'Theme Mode',
    });
    return '$_temp0';
  }

  @override
  String get chooseTheme => 'Choose Theme';

  @override
  String get confirm => 'Confirm';

  @override
  String languageMode(String language) {
    String _temp0 = intl.Intl.selectLogic(language, {
      'en': 'English',
      'fa': 'فارسی',
      'system': 'System Default',
      'other': 'Language',
    });
    return '$_temp0';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get language => 'Language';

  @override
  String get settings => 'Settings';

  @override
  String get teacherMate => 'Teacher Mate';

  @override
  String get addClass => 'Add Class';

  @override
  String get createClass => 'Create Class';

  @override
  String get save => 'Save';

  @override
  String get classTitleLabel => 'Class Title*';

  @override
  String get enterClassTitleError => 'Enter class title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get durationLabel => 'Duration (min)*';

  @override
  String get enterDurationError => 'Enter duration';

  @override
  String get numberOfSessionsLabel => 'Number of Sessions*';

  @override
  String get enterSessionCountError => 'Enter session count';

  @override
  String get pickFirstSessionDate => 'Pick Starting Class Date*';

  @override
  String firstSessionDate(Object date) {
    return 'Starting Class Date: $date';
  }

  @override
  String get syllabusLabel => 'Syllabus';

  @override
  String get requiredFieldsNote => 'Fields marked with * are required.';

  @override
  String get createStudent => 'Add Student';

  @override
  String get studentNameLabel => 'Student Name*';

  @override
  String get enterStudentNameError => 'Please enter the student\'s name';

  @override
  String get phoneLabel => 'Phone Number';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get noteLabel => 'Note';

  @override
  String get pickSessionDate => 'Pick a session date and time*';

  @override
  String date(Object date) {
    return 'Date: $date';
  }

  @override
  String get dateTitle => 'Date';

  @override
  String scheduleSession(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'Schedule Session $valueString';
  }

  @override
  String get loading => 'Loading...';

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get overview => 'Overview';

  @override
  String get description => 'Description';

  @override
  String duration(int duration) {
    final intl.NumberFormat durationNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String durationString = durationNumberFormat.format(duration);

    return '$durationString min';
  }

  @override
  String get durationPerSession => 'Duration/Session';

  @override
  String get totalSessions => 'Total Sessions';

  @override
  String get startsOn => 'Starts On';

  @override
  String get syllabusOutline => 'Syllabus Outline';

  @override
  String get students => 'Students';

  @override
  String get enrollNewStudent => 'Enroll New Student';

  @override
  String get noStudentsYet => 'No Students Yet';

  @override
  String get tapToEnrollFirstStudent =>
      'Tap the \"+\" icon above to enroll the first student.';

  @override
  String get errorLoadingStudents => 'Error Loading Students';

  @override
  String get errorLoadingSessions => 'Error Loading Sessions';

  @override
  String get sessions => 'Sessions';

  @override
  String get scheduleNewSession => 'Schedule New Session';

  @override
  String get noSessionsScheduled => 'No Sessions Scheduled';

  @override
  String get tapToScheduleFirstSession =>
      'Tap the \"+\" button to schedule the first session.';

  @override
  String sessionNumber(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'Session $valueString';
  }

  @override
  String get sessionDetails => 'Session Details';

  @override
  String get sessionDuration => 'Duration';

  @override
  String get status => 'Status';

  @override
  String get endsOn => 'Ends On';

  @override
  String get topic => 'Topic';

  @override
  String get notes => 'Notes';

  @override
  String get note => 'Note';

  @override
  String get errorLoadingSession => 'Error loading session.';

  @override
  String get homework => 'Homework';

  @override
  String sessionNumberShort(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return ' S$valueString';
  }

  @override
  String get studentShort => 'S';

  @override
  String get editNote => 'Edit Note';

  @override
  String get enterNoteHint => 'Enter Note';

  @override
  String get editHomework => 'Edit Homework';

  @override
  String get enterHomeworkHint => 'Enter Homework';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get completed => 'Completed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get substitute => 'Substitute';

  @override
  String sessionStatus(String session_status) {
    String _temp0 = intl.Intl.selectLogic(session_status, {
      'scheduled': 'Scheduled',
      'completed': 'Completed',
      'cancelled': 'Cancelled',
      'substitute': 'Substitute',
      'all': 'All',
      'other': 'SessionStatus',
    });
    return '$_temp0';
  }

  @override
  String get addNote => 'Add Note';

  @override
  String get addHomework => 'Add Homework';

  @override
  String get attendance => 'Attendance';

  @override
  String get classActivity => 'Activity';

  @override
  String get goToClassToAddStudents => 'Head to the Class Page to Add Students';

  @override
  String sessionSummary(Object dateFormatted, int sessionCount, int count) {
    final intl.NumberFormat sessionCountNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String sessionCountString = sessionCountNumberFormat.format(
      sessionCount,
    );
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'From: $dateFormatted • $sessionCountString sessions • $countString left';
  }

  @override
  String get sessionsLeft => 'Sessions Left';

  @override
  String get selectWeekdaysLabel => 'Select days of the week for sessions*';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get pickFirstSessionDateError => 'Please pick the start session date.';

  @override
  String get selectSessionDaysError =>
      'Please select at least one session day.';

  @override
  String get deactivate => 'Deactivate';

  @override
  String get activate => 'Activate';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get deactivateQuestion =>
      'Are you sure you want to deactivate this class?';

  @override
  String get activateQuestion =>
      'Are you sure you want to activate this class?';

  @override
  String get addSyllabus => 'Add Syllabus';

  @override
  String get enterSyllabusHint => 'Enter Syllabus';

  @override
  String get editClass => 'Edit Class';

  @override
  String get quizzes => 'Quizzes';

  @override
  String get createNewQuiz => 'Create New Quiz';

  @override
  String get noQuizzesYet => 'No quizzes scheduled yet';

  @override
  String get tapToAddFirstQuiz =>
      'Tap the \'+\' button to schedule your first quiz.';

  @override
  String get errorLoadingQuizzes => 'Error loading quizzes';

  @override
  String get errorLoadingClass => 'Error loading class details';

  @override
  String get quizTitleLabel => 'Quiz Title*';

  @override
  String get enterQuizTitleHint => 'E.g., Chapter 1 Review';

  @override
  String get quizDescriptionLabel => 'Description (Optional)';

  @override
  String get enterQuizDescriptionHint => 'Any extra details about the quiz...';

  @override
  String get pickQuizDate => 'Pick Quiz Date*';

  @override
  String get enterQuizTitleError => 'Please enter a quiz title.';

  @override
  String get pickQuizDateError => 'Please pick a date for the quiz.';

  @override
  String get quizDetails => 'Quiz Details';

  @override
  String get studentScores => 'Student Scores';

  @override
  String get saveResults => 'Save Results';

  @override
  String get noStudentsInClassForQuiz =>
      'No students are enrolled in this class to assign scores.';

  @override
  String get scoreLabel => 'Score';

  @override
  String get errorLoadingQuizDetails => 'Error: Could not load quiz details.';

  @override
  String get errorLoadingQuizResults => 'Error: Could not load quiz results.';

  @override
  String get errorSavingResults => 'Error saving results';

  @override
  String get quizResultsSaved => 'Quiz results saved successfully!';

  @override
  String get loadingScoreInput => 'Loading score...';

  @override
  String invalidScoreFormatFor(Object studentName) {
    return 'Invalid score format for $studentName.';
  }

  @override
  String get invalidNumberShort => 'Invalid';

  @override
  String get scorePositiveShort => '>=0';

  @override
  String get title => 'Title';

  @override
  String get fixScoreErrors =>
      'Please correct the errors in scores before saving.';

  @override
  String get resultsSaved => 'Quiz results saved successfully!';

  @override
  String get studentDetails => 'Student Details';

  @override
  String get performanceSummary => 'Performance Summary';

  @override
  String get totalAttendance => 'Attendance';

  @override
  String get totalHomework => 'Homework';

  @override
  String get totalActivities => 'Class Activities';

  @override
  String get quizScores => 'Quiz Scores';

  @override
  String get noQuizzesTaken => 'No quizzes taken yet.';

  @override
  String get errorLoadingStudentDetails => 'Error loading student details.';

  @override
  String get errorLoadingActivities => 'Error loading student activities.';

  @override
  String get errorLoadingQuizScores => 'Error loading quiz scores.';

  @override
  String get studentNote => 'Student Note';

  @override
  String get addStudentNote => 'Add Note';

  @override
  String get editStudentNote => 'Edit Note';

  @override
  String get enterStudentNoteHint => 'Enter any notes about the student...';

  @override
  String get noNoteForStudent => 'No note recorded for this student.';

  @override
  String get unknownQuiz => 'Unknown Quiz';

  @override
  String basedOnNSessions(Object count) {
    return 'Based on $count recorded sessions';
  }

  @override
  String get addDescription => 'Add Description';

  @override
  String get editDescription => 'Edit Description';

  @override
  String get enterDescription => 'Enter Description';

  @override
  String get inactiveClasses => 'Inactive Classes';

  @override
  String get classes => 'Classes';

  @override
  String get upcomingQuiz => 'Upcoming Quiz';

  @override
  String get upcomingSession => 'Upcoming Session';

  @override
  String get today => 'Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get editSessionDateTimeTitle => 'Edit Session Date & Time';

  @override
  String get selectNewDateTimePrompt => 'Please select the new date and time.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get saveButton => 'Save';

  @override
  String get sessionDateTimeUpdatedSuccess => 'Session date and time updated!';

  @override
  String get errorUpdatingSessionDateTime => 'Error updating session date/time';

  @override
  String get editDateTooltip => 'Edit session date and time';

  @override
  String get editQuizDateTimeTitle => 'Edit Quiz Date & Time';

  @override
  String get pickQuizDateTime => 'Pick Quiz Date & Time';

  @override
  String get quizDateTimeUpdatedSuccess => 'Quiz date and time updated!';

  @override
  String get errorUpdatingQuizDateTime => 'Error updating quiz date/time';

  @override
  String get editDescriptionTooltip => 'Edit description';

  @override
  String get errorLoadingQuiz => 'Error loading quiz details';

  @override
  String get confirmDeleteTitle => 'Confirm Delete';

  @override
  String get confirmDeleteSessionMessage =>
      'Are you sure you want to delete this session?';

  @override
  String get delete => 'Delete';

  @override
  String get deleteSession => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get confirmDeleteQuizMessage =>
      'Are you sure you want to delete this quiz?';

  @override
  String get deleteQuiz => 'Delete Quiz';

  @override
  String get confirmDeleteStudentMessage =>
      'Are you sure you want to delete this student?';

  @override
  String get deleteStudent => 'Delete Student';

  @override
  String get confirmDeleteClassMessage =>
      'Are you sure you want to delete this class? This will also delete all its students, sessions, and quizzes.';

  @override
  String get deleteClass => 'Delete Class';

  @override
  String get maxScoreLabel => 'Max Score';

  @override
  String get enterMaxScoreHint => 'Enter the maximum score (optional)';

  @override
  String get scores => 'Scores';

  @override
  String scoresFrom(int maxScore) {
    final intl.NumberFormat maxScoreNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String maxScoreString = maxScoreNumberFormat.format(maxScore);

    return 'Scores from $maxScoreString';
  }

  @override
  String get editMaxScore => 'Edit Max Score';

  @override
  String get addMaxScore => 'Add Max Score';

  @override
  String get enterMaxScore => 'Enter Max Score';

  @override
  String get emptyClassesCaption =>
      'You have no classes.\nUse the + button to add a new class.';

  @override
  String get selectFromCalendar => 'Select from Calendar';

  @override
  String get selectFromSessionDates => 'Select from Session Dates';

  @override
  String get noScheduledSessions => 'No scheduled sessions found.';

  @override
  String get selectSession => 'Select Session';

  @override
  String get share => 'Share';

  @override
  String get shareAsText => 'Share as Text';

  @override
  String get shareAsImage => 'Share as Image';

  @override
  String get imageCaptureFailed => 'Image capture failed.';

  @override
  String get shareFailed => 'Share failed';

  @override
  String get session => 'Session';

  @override
  String get classLabel => 'Class';

  @override
  String get className => 'Class Name';

  @override
  String get subject => 'Subject';

  @override
  String get grade => 'Grade';

  @override
  String get quiz => 'Quiz';

  @override
  String get classDetail => 'Class Detail';

  @override
  String get minutes => 'Minutes';

  @override
  String get notSet => 'Not set';

  @override
  String get shareClass => 'Share Class';

  @override
  String get pickSessionDateError => 'Please pick a date for the session.';

  @override
  String get welcomeTitle => 'Welcome to ';

  @override
  String get welcomeAppName => 'Teacher Mate!';

  @override
  String get welcomeDescription =>
      'Your companion for managing classes, students, sessions, and quizzes — all in one place.\n\nOrganize your teaching life, track progress effortlessly, and focus more on what matters most: teaching and inspiring.\n\nLet\'s make every class count! 🎓✨';

  @override
  String get iAgreeTo => 'I agree to the ';

  @override
  String get termsTitle => 'Terms and Conditions';

  @override
  String get termsDialogContent =>
      'By using this app, you agree to the following Terms of Service. Please read them carefully.\n\n1. Local Data Storage\nAll information and data you enter into Teacher Mate — including class details, student records, sessions, and quiz data — are stored locally on your device.\nWe do not collect, transmit, or store any user data on external servers. You are solely responsible for backing up your data and ensuring its integrity.\n\n2. User Responsibility\nAs a user of Teacher Mate, you agree to:\n• Use the app only for lawful and educational purposes.\n• Ensure that any data you input (e.g., student names or notes) complies with local laws and institutional policies.\n• Accept full responsibility for maintaining, securing, and, if necessary, deleting your stored information.\nWe are not liable for any loss, corruption, or misuse of your data.\n\n3. No Account or Cloud Integration\nTeacher Mate does not require an account or internet connection. There is no cloud sync or remote backup at this time. All data resides on the device and is inaccessible to the app developers.\n\n4. Limitation of Liability\nTeacher Mate is provided \"as is\" without warranties of any kind. We are not liable for any direct, indirect, incidental, or consequential damages arising from the use (or inability to use) the app.\nThis includes, but is not limited to, data loss, incorrect reporting, or missed sessions.\n\n5. Intellectual Property\nAll logos, designs, and the app interface are the property of the Teacher Mate development team. You may not copy, reproduce, or distribute any part of the app without written permission.\n\n6. Prohibited Use\nYou agree not to:\n• Reverse-engineer, decompile, or tamper with the app.\n• Use the app for commercial resale or unauthorized distribution.\n• Store or process sensitive data that you\'re not legally allowed to handle.\n\n7. Updates and Changes\nWe may update the app to fix bugs, improve performance, or add features. These updates may change the behavior or appearance of the app, and continued use implies acceptance of such changes.\n\n8. Termination\nWe reserve the right to discontinue the app or restrict access if you breach these terms. You can also stop using the app at any time by uninstalling it.\n\n9. Governing Law\nThese terms are governed by the laws of your local jurisdiction. Any disputes shall be handled in accordance with those laws.\n\nBy continuing to use Teacher Mate, you confirm that you have read, understood, and agreed to these Terms of Service.';

  @override
  String get close => 'Close';

  @override
  String get getStarted => 'Get Started';

  @override
  String get createQuiz => 'Create Quiz';

  @override
  String get enrollStudent => 'Enroll Student';

  @override
  String get scheduleSessionBtn => 'Schedule Session';

  @override
  String get beta => 'BETA';

  @override
  String get shareSession => 'Share Session';

  @override
  String get shareQuiz => 'Share Quiz';

  @override
  String get quizResults => 'Quiz Results';

  @override
  String get themeModeTitle => 'Theme Mode';

  @override
  String get themeColorTitle => 'Theme Color';

  @override
  String themeColor(String theme_color) {
    String _temp0 = intl.Intl.selectLogic(theme_color, {
      'blue': 'Blue',
      'yellow': 'Yellow',
      'pink': 'Pink',
      'purple': 'Purple',
      'green': 'Green',
      'red': 'Red',
      'other': 'Theme Color',
    });
    return '$_temp0';
  }

  @override
  String get addModeSingle => 'Single';

  @override
  String get addModeMultiple => 'Multiple';

  @override
  String get calendar => 'Calendar';

  @override
  String calendarType(String calendar_type) {
    String _temp0 = intl.Intl.selectLogic(calendar_type, {
      'gregorian': 'Gregorian',
      'persian': 'Persian',
      'other': 'Calendar Type',
    });
    return '$_temp0';
  }

  @override
  String get student => 'Student';

  @override
  String get studentReport => 'Student Report';

  @override
  String get shareStudentReport => 'Share Student Report';

  @override
  String get age => 'Age';

  @override
  String get background => 'Background';

  @override
  String get addAge => 'Add Age';

  @override
  String get addBackground => 'Add Background';

  @override
  String get addStudentAge => 'Add Student Age';

  @override
  String get editStudentAge => 'Edit Student Age';

  @override
  String get addStudentBackground => 'Add Student Background';

  @override
  String get editStudentBackground => 'Edit Student Background';

  @override
  String get enterStudentAgeHint => 'Enter student age';

  @override
  String get enterStudentBackgroundHint => 'Enter student background';

  @override
  String get all => 'All';

  @override
  String get noSessionsFoundForFilter => 'No sessions found for this filter.';

  @override
  String get tryDifferentFilter =>
      'Try a different filter or check your schedule.';
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa'),
  ];

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'{theme_mode, select, dark{Dark} light{Light} system{System Default}  other{Theme Mode}}'**
  String themeMode(String theme_mode);

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose Theme'**
  String get chooseTheme;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @languageMode.
  ///
  /// In en, this message translates to:
  /// **'{language, select, en{English} fa{فارسی} system{System Default}  other{Language}}'**
  String languageMode(String language);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @teacherMate.
  ///
  /// In en, this message translates to:
  /// **'Teacher Mate'**
  String get teacherMate;

  /// No description provided for @addClass.
  ///
  /// In en, this message translates to:
  /// **'Add Class'**
  String get addClass;

  /// No description provided for @createClass.
  ///
  /// In en, this message translates to:
  /// **'Create Class'**
  String get createClass;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @classTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Class Title*'**
  String get classTitleLabel;

  /// No description provided for @enterClassTitleError.
  ///
  /// In en, this message translates to:
  /// **'Enter class title'**
  String get enterClassTitleError;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @durationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration (min)*'**
  String get durationLabel;

  /// No description provided for @enterDurationError.
  ///
  /// In en, this message translates to:
  /// **'Enter duration'**
  String get enterDurationError;

  /// No description provided for @numberOfSessionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Number of Sessions*'**
  String get numberOfSessionsLabel;

  /// No description provided for @enterSessionCountError.
  ///
  /// In en, this message translates to:
  /// **'Enter session count'**
  String get enterSessionCountError;

  /// No description provided for @pickFirstSessionDate.
  ///
  /// In en, this message translates to:
  /// **'Pick Starting Class Date*'**
  String get pickFirstSessionDate;

  /// No description provided for @firstSessionDate.
  ///
  /// In en, this message translates to:
  /// **'Starting Class Date: {date}'**
  String firstSessionDate(Object date);

  /// No description provided for @syllabusLabel.
  ///
  /// In en, this message translates to:
  /// **'Syllabus'**
  String get syllabusLabel;

  /// No description provided for @requiredFieldsNote.
  ///
  /// In en, this message translates to:
  /// **'Fields marked with * are required.'**
  String get requiredFieldsNote;

  /// No description provided for @createStudent.
  ///
  /// In en, this message translates to:
  /// **'Add Student'**
  String get createStudent;

  /// No description provided for @studentNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Student Name*'**
  String get studentNameLabel;

  /// No description provided for @enterStudentNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter the student\'\'s name'**
  String get enterStudentNameError;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailLabel;

  /// No description provided for @noteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteLabel;

  /// No description provided for @pickSessionDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a session date and time*'**
  String get pickSessionDate;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String date(Object date);

  /// No description provided for @dateTitle.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateTitle;

  /// No description provided for @scheduleSession.
  ///
  /// In en, this message translates to:
  /// **'Schedule Session {value}'**
  String scheduleSession(int value);

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(Object error);

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'{duration} min'**
  String duration(int duration);

  /// No description provided for @durationPerSession.
  ///
  /// In en, this message translates to:
  /// **'Duration/Session'**
  String get durationPerSession;

  /// No description provided for @totalSessions.
  ///
  /// In en, this message translates to:
  /// **'Total Sessions'**
  String get totalSessions;

  /// No description provided for @startsOn.
  ///
  /// In en, this message translates to:
  /// **'Starts On'**
  String get startsOn;

  /// No description provided for @syllabusOutline.
  ///
  /// In en, this message translates to:
  /// **'Syllabus Outline'**
  String get syllabusOutline;

  /// No description provided for @students.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get students;

  /// No description provided for @enrollNewStudent.
  ///
  /// In en, this message translates to:
  /// **'Enroll New Student'**
  String get enrollNewStudent;

  /// No description provided for @noStudentsYet.
  ///
  /// In en, this message translates to:
  /// **'No Students Yet'**
  String get noStudentsYet;

  /// No description provided for @tapToEnrollFirstStudent.
  ///
  /// In en, this message translates to:
  /// **'Tap the \"+\" icon above to enroll the first student.'**
  String get tapToEnrollFirstStudent;

  /// No description provided for @errorLoadingStudents.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Students'**
  String get errorLoadingStudents;

  /// No description provided for @errorLoadingSessions.
  ///
  /// In en, this message translates to:
  /// **'Error Loading Sessions'**
  String get errorLoadingSessions;

  /// No description provided for @sessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get sessions;

  /// No description provided for @scheduleNewSession.
  ///
  /// In en, this message translates to:
  /// **'Schedule New Session'**
  String get scheduleNewSession;

  /// No description provided for @noSessionsScheduled.
  ///
  /// In en, this message translates to:
  /// **'No Sessions Scheduled'**
  String get noSessionsScheduled;

  /// No description provided for @tapToScheduleFirstSession.
  ///
  /// In en, this message translates to:
  /// **'Tap the \"+\" button to schedule the first session.'**
  String get tapToScheduleFirstSession;

  /// No description provided for @sessionNumber.
  ///
  /// In en, this message translates to:
  /// **'Session {value}'**
  String sessionNumber(int value);

  /// No description provided for @sessionDetails.
  ///
  /// In en, this message translates to:
  /// **'Session Details'**
  String get sessionDetails;

  /// No description provided for @sessionDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get sessionDuration;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @endsOn.
  ///
  /// In en, this message translates to:
  /// **'Ends On'**
  String get endsOn;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @errorLoadingSession.
  ///
  /// In en, this message translates to:
  /// **'Error loading session.'**
  String get errorLoadingSession;

  /// No description provided for @homework.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get homework;

  /// No description provided for @sessionNumberShort.
  ///
  /// In en, this message translates to:
  /// **' S{value}'**
  String sessionNumberShort(int value);

  /// No description provided for @studentShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get studentShort;

  /// No description provided for @editNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editNote;

  /// No description provided for @enterNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Note'**
  String get enterNoteHint;

  /// No description provided for @editHomework.
  ///
  /// In en, this message translates to:
  /// **'Edit Homework'**
  String get editHomework;

  /// No description provided for @enterHomeworkHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Homework'**
  String get enterHomeworkHint;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @substitute.
  ///
  /// In en, this message translates to:
  /// **'Substitute'**
  String get substitute;

  /// No description provided for @sessionStatus.
  ///
  /// In en, this message translates to:
  /// **'{session_status, select, scheduled{Scheduled} completed{Completed} cancelled{Cancelled} substitute{Substitute} all{All} other{SessionStatus}}'**
  String sessionStatus(String session_status);

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addNote;

  /// No description provided for @addHomework.
  ///
  /// In en, this message translates to:
  /// **'Add Homework'**
  String get addHomework;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @classActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get classActivity;

  /// No description provided for @goToClassToAddStudents.
  ///
  /// In en, this message translates to:
  /// **'Head to the Class Page to Add Students'**
  String get goToClassToAddStudents;

  /// No description provided for @sessionSummary.
  ///
  /// In en, this message translates to:
  /// **'From: {dateFormatted} • {sessionCount} sessions • {count} left'**
  String sessionSummary(Object dateFormatted, int sessionCount, int count);

  /// No description provided for @sessionsLeft.
  ///
  /// In en, this message translates to:
  /// **'Sessions Left'**
  String get sessionsLeft;

  /// No description provided for @selectWeekdaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Select days of the week for sessions*'**
  String get selectWeekdaysLabel;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @pickFirstSessionDateError.
  ///
  /// In en, this message translates to:
  /// **'Please pick the start session date.'**
  String get pickFirstSessionDateError;

  /// No description provided for @selectSessionDaysError.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one session day.'**
  String get selectSessionDaysError;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @deactivateQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to deactivate this class?'**
  String get deactivateQuestion;

  /// No description provided for @activateQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to activate this class?'**
  String get activateQuestion;

  /// No description provided for @addSyllabus.
  ///
  /// In en, this message translates to:
  /// **'Add Syllabus'**
  String get addSyllabus;

  /// No description provided for @enterSyllabusHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Syllabus'**
  String get enterSyllabusHint;

  /// No description provided for @editClass.
  ///
  /// In en, this message translates to:
  /// **'Edit Class'**
  String get editClass;

  /// No description provided for @quizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get quizzes;

  /// No description provided for @createNewQuiz.
  ///
  /// In en, this message translates to:
  /// **'Create New Quiz'**
  String get createNewQuiz;

  /// No description provided for @noQuizzesYet.
  ///
  /// In en, this message translates to:
  /// **'No quizzes scheduled yet'**
  String get noQuizzesYet;

  /// No description provided for @tapToAddFirstQuiz.
  ///
  /// In en, this message translates to:
  /// **'Tap the \'\'+\'\' button to schedule your first quiz.'**
  String get tapToAddFirstQuiz;

  /// No description provided for @errorLoadingQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Error loading quizzes'**
  String get errorLoadingQuizzes;

  /// No description provided for @errorLoadingClass.
  ///
  /// In en, this message translates to:
  /// **'Error loading class details'**
  String get errorLoadingClass;

  /// No description provided for @quizTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Quiz Title*'**
  String get quizTitleLabel;

  /// No description provided for @enterQuizTitleHint.
  ///
  /// In en, this message translates to:
  /// **'E.g., Chapter 1 Review'**
  String get enterQuizTitleHint;

  /// No description provided for @quizDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get quizDescriptionLabel;

  /// No description provided for @enterQuizDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Any extra details about the quiz...'**
  String get enterQuizDescriptionHint;

  /// No description provided for @pickQuizDate.
  ///
  /// In en, this message translates to:
  /// **'Pick Quiz Date*'**
  String get pickQuizDate;

  /// No description provided for @enterQuizTitleError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a quiz title.'**
  String get enterQuizTitleError;

  /// No description provided for @pickQuizDateError.
  ///
  /// In en, this message translates to:
  /// **'Please pick a date for the quiz.'**
  String get pickQuizDateError;

  /// No description provided for @quizDetails.
  ///
  /// In en, this message translates to:
  /// **'Quiz Details'**
  String get quizDetails;

  /// No description provided for @studentScores.
  ///
  /// In en, this message translates to:
  /// **'Student Scores'**
  String get studentScores;

  /// No description provided for @saveResults.
  ///
  /// In en, this message translates to:
  /// **'Save Results'**
  String get saveResults;

  /// No description provided for @noStudentsInClassForQuiz.
  ///
  /// In en, this message translates to:
  /// **'No students are enrolled in this class to assign scores.'**
  String get noStudentsInClassForQuiz;

  /// No description provided for @scoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get scoreLabel;

  /// No description provided for @errorLoadingQuizDetails.
  ///
  /// In en, this message translates to:
  /// **'Error: Could not load quiz details.'**
  String get errorLoadingQuizDetails;

  /// No description provided for @errorLoadingQuizResults.
  ///
  /// In en, this message translates to:
  /// **'Error: Could not load quiz results.'**
  String get errorLoadingQuizResults;

  /// No description provided for @errorSavingResults.
  ///
  /// In en, this message translates to:
  /// **'Error saving results'**
  String get errorSavingResults;

  /// No description provided for @quizResultsSaved.
  ///
  /// In en, this message translates to:
  /// **'Quiz results saved successfully!'**
  String get quizResultsSaved;

  /// No description provided for @loadingScoreInput.
  ///
  /// In en, this message translates to:
  /// **'Loading score...'**
  String get loadingScoreInput;

  /// No description provided for @invalidScoreFormatFor.
  ///
  /// In en, this message translates to:
  /// **'Invalid score format for {studentName}.'**
  String invalidScoreFormatFor(Object studentName);

  /// No description provided for @invalidNumberShort.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalidNumberShort;

  /// No description provided for @scorePositiveShort.
  ///
  /// In en, this message translates to:
  /// **'>=0'**
  String get scorePositiveShort;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @fixScoreErrors.
  ///
  /// In en, this message translates to:
  /// **'Please correct the errors in scores before saving.'**
  String get fixScoreErrors;

  /// No description provided for @resultsSaved.
  ///
  /// In en, this message translates to:
  /// **'Quiz results saved successfully!'**
  String get resultsSaved;

  /// No description provided for @studentDetails.
  ///
  /// In en, this message translates to:
  /// **'Student Details'**
  String get studentDetails;

  /// No description provided for @performanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Performance Summary'**
  String get performanceSummary;

  /// No description provided for @totalAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get totalAttendance;

  /// No description provided for @totalHomework.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get totalHomework;

  /// No description provided for @totalActivities.
  ///
  /// In en, this message translates to:
  /// **'Class Activities'**
  String get totalActivities;

  /// No description provided for @quizScores.
  ///
  /// In en, this message translates to:
  /// **'Quiz Scores'**
  String get quizScores;

  /// No description provided for @noQuizzesTaken.
  ///
  /// In en, this message translates to:
  /// **'No quizzes taken yet.'**
  String get noQuizzesTaken;

  /// No description provided for @errorLoadingStudentDetails.
  ///
  /// In en, this message translates to:
  /// **'Error loading student details.'**
  String get errorLoadingStudentDetails;

  /// No description provided for @errorLoadingActivities.
  ///
  /// In en, this message translates to:
  /// **'Error loading student activities.'**
  String get errorLoadingActivities;

  /// No description provided for @errorLoadingQuizScores.
  ///
  /// In en, this message translates to:
  /// **'Error loading quiz scores.'**
  String get errorLoadingQuizScores;

  /// No description provided for @studentNote.
  ///
  /// In en, this message translates to:
  /// **'Student Note'**
  String get studentNote;

  /// No description provided for @addStudentNote.
  ///
  /// In en, this message translates to:
  /// **'Add Note'**
  String get addStudentNote;

  /// No description provided for @editStudentNote.
  ///
  /// In en, this message translates to:
  /// **'Edit Note'**
  String get editStudentNote;

  /// No description provided for @enterStudentNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Enter any notes about the student...'**
  String get enterStudentNoteHint;

  /// No description provided for @noNoteForStudent.
  ///
  /// In en, this message translates to:
  /// **'No note recorded for this student.'**
  String get noNoteForStudent;

  /// No description provided for @unknownQuiz.
  ///
  /// In en, this message translates to:
  /// **'Unknown Quiz'**
  String get unknownQuiz;

  /// No description provided for @basedOnNSessions.
  ///
  /// In en, this message translates to:
  /// **'Based on {count} recorded sessions'**
  String basedOnNSessions(Object count);

  /// No description provided for @addDescription.
  ///
  /// In en, this message translates to:
  /// **'Add Description'**
  String get addDescription;

  /// No description provided for @editDescription.
  ///
  /// In en, this message translates to:
  /// **'Edit Description'**
  String get editDescription;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter Description'**
  String get enterDescription;

  /// No description provided for @inactiveClasses.
  ///
  /// In en, this message translates to:
  /// **'Inactive Classes'**
  String get inactiveClasses;

  /// No description provided for @classes.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get classes;

  /// No description provided for @upcomingQuiz.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Quiz'**
  String get upcomingQuiz;

  /// No description provided for @upcomingSession.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Session'**
  String get upcomingSession;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @editSessionDateTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Session Date & Time'**
  String get editSessionDateTimeTitle;

  /// No description provided for @selectNewDateTimePrompt.
  ///
  /// In en, this message translates to:
  /// **'Please select the new date and time.'**
  String get selectNewDateTimePrompt;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @sessionDateTimeUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Session date and time updated!'**
  String get sessionDateTimeUpdatedSuccess;

  /// No description provided for @errorUpdatingSessionDateTime.
  ///
  /// In en, this message translates to:
  /// **'Error updating session date/time'**
  String get errorUpdatingSessionDateTime;

  /// No description provided for @editDateTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit session date and time'**
  String get editDateTooltip;

  /// No description provided for @editQuizDateTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Quiz Date & Time'**
  String get editQuizDateTimeTitle;

  /// No description provided for @pickQuizDateTime.
  ///
  /// In en, this message translates to:
  /// **'Pick Quiz Date & Time'**
  String get pickQuizDateTime;

  /// No description provided for @quizDateTimeUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Quiz date and time updated!'**
  String get quizDateTimeUpdatedSuccess;

  /// No description provided for @errorUpdatingQuizDateTime.
  ///
  /// In en, this message translates to:
  /// **'Error updating quiz date/time'**
  String get errorUpdatingQuizDateTime;

  /// No description provided for @editDescriptionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit description'**
  String get editDescriptionTooltip;

  /// No description provided for @errorLoadingQuiz.
  ///
  /// In en, this message translates to:
  /// **'Error loading quiz details'**
  String get errorLoadingQuiz;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteSessionMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this session?'**
  String get confirmDeleteSessionMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteSession.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteSession;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @confirmDeleteQuizMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this quiz?'**
  String get confirmDeleteQuizMessage;

  /// No description provided for @deleteQuiz.
  ///
  /// In en, this message translates to:
  /// **'Delete Quiz'**
  String get deleteQuiz;

  /// No description provided for @confirmDeleteStudentMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this student?'**
  String get confirmDeleteStudentMessage;

  /// No description provided for @deleteStudent.
  ///
  /// In en, this message translates to:
  /// **'Delete Student'**
  String get deleteStudent;

  /// No description provided for @confirmDeleteClassMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this class? This will also delete all its students, sessions, and quizzes.'**
  String get confirmDeleteClassMessage;

  /// No description provided for @deleteClass.
  ///
  /// In en, this message translates to:
  /// **'Delete Class'**
  String get deleteClass;

  /// No description provided for @maxScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Score'**
  String get maxScoreLabel;

  /// No description provided for @enterMaxScoreHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the maximum score (optional)'**
  String get enterMaxScoreHint;

  /// No description provided for @scores.
  ///
  /// In en, this message translates to:
  /// **'Scores'**
  String get scores;

  /// No description provided for @scoresFrom.
  ///
  /// In en, this message translates to:
  /// **'Scores from {maxScore}'**
  String scoresFrom(int maxScore);

  /// No description provided for @editMaxScore.
  ///
  /// In en, this message translates to:
  /// **'Edit Max Score'**
  String get editMaxScore;

  /// No description provided for @addMaxScore.
  ///
  /// In en, this message translates to:
  /// **'Add Max Score'**
  String get addMaxScore;

  /// No description provided for @enterMaxScore.
  ///
  /// In en, this message translates to:
  /// **'Enter Max Score'**
  String get enterMaxScore;

  /// No description provided for @emptyClassesCaption.
  ///
  /// In en, this message translates to:
  /// **'You have no classes.\nUse the + button to add a new class.'**
  String get emptyClassesCaption;

  /// No description provided for @selectFromCalendar.
  ///
  /// In en, this message translates to:
  /// **'Select from Calendar'**
  String get selectFromCalendar;

  /// No description provided for @selectFromSessionDates.
  ///
  /// In en, this message translates to:
  /// **'Select from Session Dates'**
  String get selectFromSessionDates;

  /// No description provided for @noScheduledSessions.
  ///
  /// In en, this message translates to:
  /// **'No scheduled sessions found.'**
  String get noScheduledSessions;

  /// No description provided for @selectSession.
  ///
  /// In en, this message translates to:
  /// **'Select Session'**
  String get selectSession;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shareAsText.
  ///
  /// In en, this message translates to:
  /// **'Share as Text'**
  String get shareAsText;

  /// No description provided for @shareAsImage.
  ///
  /// In en, this message translates to:
  /// **'Share as Image'**
  String get shareAsImage;

  /// No description provided for @imageCaptureFailed.
  ///
  /// In en, this message translates to:
  /// **'Image capture failed.'**
  String get imageCaptureFailed;

  /// No description provided for @shareFailed.
  ///
  /// In en, this message translates to:
  /// **'Share failed'**
  String get shareFailed;

  /// No description provided for @session.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get session;

  /// No description provided for @classLabel.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get classLabel;

  /// No description provided for @className.
  ///
  /// In en, this message translates to:
  /// **'Class Name'**
  String get className;

  /// No description provided for @subject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subject;

  /// No description provided for @grade.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get grade;

  /// No description provided for @quiz.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get quiz;

  /// No description provided for @classDetail.
  ///
  /// In en, this message translates to:
  /// **'Class Detail'**
  String get classDetail;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @shareClass.
  ///
  /// In en, this message translates to:
  /// **'Share Class'**
  String get shareClass;

  /// No description provided for @pickSessionDateError.
  ///
  /// In en, this message translates to:
  /// **'Please pick a date for the session.'**
  String get pickSessionDateError;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to '**
  String get welcomeTitle;

  /// No description provided for @welcomeAppName.
  ///
  /// In en, this message translates to:
  /// **'Teacher Mate!'**
  String get welcomeAppName;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your companion for managing classes, students, sessions, and quizzes — all in one place.\n\nOrganize your teaching life, track progress effortlessly, and focus more on what matters most: teaching and inspiring.\n\nLet\'\'s make every class count! 🎓✨'**
  String get welcomeDescription;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get iAgreeTo;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsTitle;

  /// No description provided for @termsDialogContent.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to the following Terms of Service. Please read them carefully.\n\n1. Local Data Storage\nAll information and data you enter into Teacher Mate — including class details, student records, sessions, and quiz data — are stored locally on your device.\nWe do not collect, transmit, or store any user data on external servers. You are solely responsible for backing up your data and ensuring its integrity.\n\n2. User Responsibility\nAs a user of Teacher Mate, you agree to:\n• Use the app only for lawful and educational purposes.\n• Ensure that any data you input (e.g., student names or notes) complies with local laws and institutional policies.\n• Accept full responsibility for maintaining, securing, and, if necessary, deleting your stored information.\nWe are not liable for any loss, corruption, or misuse of your data.\n\n3. No Account or Cloud Integration\nTeacher Mate does not require an account or internet connection. There is no cloud sync or remote backup at this time. All data resides on the device and is inaccessible to the app developers.\n\n4. Limitation of Liability\nTeacher Mate is provided \"as is\" without warranties of any kind. We are not liable for any direct, indirect, incidental, or consequential damages arising from the use (or inability to use) the app.\nThis includes, but is not limited to, data loss, incorrect reporting, or missed sessions.\n\n5. Intellectual Property\nAll logos, designs, and the app interface are the property of the Teacher Mate development team. You may not copy, reproduce, or distribute any part of the app without written permission.\n\n6. Prohibited Use\nYou agree not to:\n• Reverse-engineer, decompile, or tamper with the app.\n• Use the app for commercial resale or unauthorized distribution.\n• Store or process sensitive data that you\'\'re not legally allowed to handle.\n\n7. Updates and Changes\nWe may update the app to fix bugs, improve performance, or add features. These updates may change the behavior or appearance of the app, and continued use implies acceptance of such changes.\n\n8. Termination\nWe reserve the right to discontinue the app or restrict access if you breach these terms. You can also stop using the app at any time by uninstalling it.\n\n9. Governing Law\nThese terms are governed by the laws of your local jurisdiction. Any disputes shall be handled in accordance with those laws.\n\nBy continuing to use Teacher Mate, you confirm that you have read, understood, and agreed to these Terms of Service.'**
  String get termsDialogContent;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @createQuiz.
  ///
  /// In en, this message translates to:
  /// **'Create Quiz'**
  String get createQuiz;

  /// No description provided for @enrollStudent.
  ///
  /// In en, this message translates to:
  /// **'Enroll Student'**
  String get enrollStudent;

  /// No description provided for @scheduleSessionBtn.
  ///
  /// In en, this message translates to:
  /// **'Schedule Session'**
  String get scheduleSessionBtn;

  /// No description provided for @beta.
  ///
  /// In en, this message translates to:
  /// **'BETA'**
  String get beta;

  /// No description provided for @shareSession.
  ///
  /// In en, this message translates to:
  /// **'Share Session'**
  String get shareSession;

  /// No description provided for @shareQuiz.
  ///
  /// In en, this message translates to:
  /// **'Share Quiz'**
  String get shareQuiz;

  /// No description provided for @quizResults.
  ///
  /// In en, this message translates to:
  /// **'Quiz Results'**
  String get quizResults;

  /// No description provided for @themeModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeModeTitle;

  /// No description provided for @themeColorTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme Color'**
  String get themeColorTitle;

  /// No description provided for @themeColor.
  ///
  /// In en, this message translates to:
  /// **'{theme_color, select, blue{Blue} yellow{Yellow} pink{Pink} purple{Purple} green{Green} red{Red} other{Theme Color}}'**
  String themeColor(String theme_color);

  /// No description provided for @addModeSingle.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get addModeSingle;

  /// No description provided for @addModeMultiple.
  ///
  /// In en, this message translates to:
  /// **'Multiple'**
  String get addModeMultiple;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @calendarType.
  ///
  /// In en, this message translates to:
  /// **'{calendar_type, select, gregorian{Gregorian} persian{Persian} other{Calendar Type}}'**
  String calendarType(String calendar_type);

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @studentReport.
  ///
  /// In en, this message translates to:
  /// **'Student Report'**
  String get studentReport;

  /// No description provided for @shareStudentReport.
  ///
  /// In en, this message translates to:
  /// **'Share Student Report'**
  String get shareStudentReport;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @addAge.
  ///
  /// In en, this message translates to:
  /// **'Add Age'**
  String get addAge;

  /// No description provided for @addBackground.
  ///
  /// In en, this message translates to:
  /// **'Add Background'**
  String get addBackground;

  /// No description provided for @addStudentAge.
  ///
  /// In en, this message translates to:
  /// **'Add Student Age'**
  String get addStudentAge;

  /// No description provided for @editStudentAge.
  ///
  /// In en, this message translates to:
  /// **'Edit Student Age'**
  String get editStudentAge;

  /// No description provided for @addStudentBackground.
  ///
  /// In en, this message translates to:
  /// **'Add Student Background'**
  String get addStudentBackground;

  /// No description provided for @editStudentBackground.
  ///
  /// In en, this message translates to:
  /// **'Edit Student Background'**
  String get editStudentBackground;

  /// No description provided for @enterStudentAgeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter student age'**
  String get enterStudentAgeHint;

  /// No description provided for @enterStudentBackgroundHint.
  ///
  /// In en, this message translates to:
  /// **'Enter student background'**
  String get enterStudentBackgroundHint;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noSessionsFoundForFilter.
  ///
  /// In en, this message translates to:
  /// **'No sessions found for this filter.'**
  String get noSessionsFoundForFilter;

  /// No description provided for @tryDifferentFilter.
  ///
  /// In en, this message translates to:
  /// **'Try a different filter or check your schedule.'**
  String get tryDifferentFilter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

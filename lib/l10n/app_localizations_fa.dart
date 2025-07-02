// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String themeMode(String theme_mode) {
    String _temp0 = intl.Intl.selectLogic(theme_mode, {
      'dark': 'تاریک',
      'light': 'روشن',
      'system': 'پیش فرض سیستم',
      'other': 'حالت تم',
    });
    return '$_temp0';
  }

  @override
  String get chooseTheme => 'انتخاب تم';

  @override
  String get confirm => 'ثبت';

  @override
  String languageMode(String language) {
    String _temp0 = intl.Intl.selectLogic(language, {
      'en': 'English',
      'fa': 'فارسی',
      'system': 'پیش فرض سیستم',
      'other': 'زبان',
    });
    return '$_temp0';
  }

  @override
  String get cancel => 'انصراف';

  @override
  String get language => 'زبان';

  @override
  String get settings => 'تنظیمات';

  @override
  String get teacherMate => 'تیچر میت';

  @override
  String get addClass => 'اضافه کردن کلاس';

  @override
  String get createClass => 'ایجاد کلاس';

  @override
  String get save => 'ذخیره';

  @override
  String get classTitleLabel => 'عنوان کلاس*';

  @override
  String get enterClassTitleError => 'عنوان کلاس را وارد کنید';

  @override
  String get descriptionLabel => 'توضیحات';

  @override
  String get durationLabel => 'مدت زمان (دقیقه)*';

  @override
  String get enterDurationError => 'مدت زمان را وارد کنید';

  @override
  String get numberOfSessionsLabel => 'تعداد جلسات*';

  @override
  String get enterSessionCountError => 'تعداد جلسات را وارد کنید';

  @override
  String get pickFirstSessionDate => 'تاریخ شروع کلاس را انتخاب کنید*';

  @override
  String firstSessionDate(Object date) {
    return 'تاریخ شروع کلاس: $date';
  }

  @override
  String get syllabusLabel => 'سرفصل‌ها';

  @override
  String get requiredFieldsNote => 'فیلدهای علامت‌گذاری‌شده با * الزامی هستند.';

  @override
  String get createStudent => 'افزودن دانش‌آموز';

  @override
  String get studentNameLabel => 'نام دانش‌آموز*';

  @override
  String get enterStudentNameError => 'لطفاً نام دانش‌آموز را وارد کنید';

  @override
  String get phoneLabel => 'شماره تلفن';

  @override
  String get emailLabel => 'آدرس ایمیل';

  @override
  String get noteLabel => 'یادداشت';

  @override
  String get pickSessionDate => 'تاریخ و زمان جلسه را انتخاب کنید*';

  @override
  String date(Object date) {
    return 'تاریخ: $date';
  }

  @override
  String get dateTitle => 'تاریخ';

  @override
  String scheduleSession(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'برنامه‌ریزی جلسه $valueString';
  }

  @override
  String get loading => 'در حال بارگذاری...';

  @override
  String error(Object error) {
    return 'خطا: $error';
  }

  @override
  String get overview => 'نمای کلی';

  @override
  String get description => 'توضیحات';

  @override
  String duration(int duration) {
    final intl.NumberFormat durationNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String durationString = durationNumberFormat.format(duration);

    return '$durationString ذقیقه';
  }

  @override
  String get durationPerSession => 'مدت هر جلسه';

  @override
  String get totalSessions => 'تعداد جلسات';

  @override
  String get startsOn => 'شروع از';

  @override
  String get syllabusOutline => 'طرح کلی سرفصل‌ها';

  @override
  String get students => 'دانش‌آموزان';

  @override
  String get enrollNewStudent => 'ثبت دانش‌آموز جدید';

  @override
  String get noStudentsYet => 'هنوز دانش‌آموزی ثبت نشده';

  @override
  String get tapToEnrollFirstStudent =>
      'روی آیکون \"+\" بالا بزنید تا اولین دانش‌آموز را ثبت کنید.';

  @override
  String get errorLoadingStudents => 'خطا در بارگذاری دانش‌آموزان';

  @override
  String get errorLoadingSessions => 'خطا در بارگذاری جلسات';

  @override
  String get sessions => 'جلسات';

  @override
  String get scheduleNewSession => 'برنامه‌ریزی جلسه جدید';

  @override
  String get noSessionsScheduled => 'هنوز جلسه‌ای برنامه‌ریزی نشده';

  @override
  String get tapToScheduleFirstSession =>
      'برای برنامه‌ریزی اولین جلسه، روی دکمه \"+\" بزنید.';

  @override
  String sessionNumber(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return 'جلسه $valueString';
  }

  @override
  String get sessionDetails => 'جزئیات جلسه';

  @override
  String get sessionDuration => 'مدت‌زمان';

  @override
  String get status => 'وضعیت';

  @override
  String get endsOn => 'پایان در';

  @override
  String get topic => 'موضوع';

  @override
  String get notes => 'یادداشت‌ها';

  @override
  String get note => 'یادداشت';

  @override
  String get errorLoadingSession => 'خطا در بارگذاری جلسه.';

  @override
  String get homework => 'تکلیف';

  @override
  String sessionNumberShort(int value) {
    final intl.NumberFormat valueNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String valueString = valueNumberFormat.format(value);

    return ' ج$valueString';
  }

  @override
  String get studentShort => 'د';

  @override
  String get editNote => 'ویرایش یادداشت';

  @override
  String get enterNoteHint => 'یادداشت را وارد کنید';

  @override
  String get editHomework => 'ویرایش تکلیف';

  @override
  String get enterHomeworkHint => 'تکلیف را وارد کنید';

  @override
  String get scheduled => 'برنامه‌ریزی‌شده';

  @override
  String get completed => 'تکمیل‌شده';

  @override
  String get cancelled => 'لغو‌شده';

  @override
  String get substitute => 'جانشین';

  @override
  String sessionStatus(String session_status) {
    String _temp0 = intl.Intl.selectLogic(session_status, {
      'scheduled': 'برنامه‌ریزی‌شده',
      'completed': 'تکمیل‌شده',
      'cancelled': 'لغو‌شده',
      'substitute': 'جانشین',
      'all': 'همه',
      'other': 'وضعیت جلسه',
    });
    return '$_temp0';
  }

  @override
  String get addNote => 'افزودن یادداشت';

  @override
  String get addHomework => 'افزودن تکلیف';

  @override
  String get attendance => 'حضور و غیاب';

  @override
  String get classActivity => 'فعالیت';

  @override
  String get goToClassToAddStudents =>
      'برای افزودن دانش‌آموز به صفحه کلاس بروید';

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

    return 'از: $dateFormatted • $sessionCountString جلسه • $countString مانده';
  }

  @override
  String get sessionsLeft => 'جلسات باقی مانده';

  @override
  String get selectWeekdaysLabel => 'روزهای هفته را برای جلسات انتخاب کنید*';

  @override
  String get monday => 'دوشنبه';

  @override
  String get tuesday => 'سه‌شنبه';

  @override
  String get wednesday => 'چهارشنبه';

  @override
  String get thursday => 'پنج‌شنبه';

  @override
  String get friday => 'جمعه';

  @override
  String get saturday => 'شنبه';

  @override
  String get sunday => 'یک‌شنبه';

  @override
  String get pickFirstSessionDateError =>
      'لطفاً تاریخ شروع کلاس را انتخاب کنید.';

  @override
  String get selectSessionDaysError =>
      'لطفاً حداقل یک روز برای جلسات انتخاب کنید.';

  @override
  String get deactivate => 'غیرفعال کردن';

  @override
  String get activate => 'فعال کردن';

  @override
  String get active => 'فعال';

  @override
  String get inactive => 'غیرفعال';

  @override
  String get deactivateQuestion =>
      'آیا از غیرفعال کردن این کلاس اطمینان دارید؟';

  @override
  String get activateQuestion => 'آیا از فعال کردن این کلاس اطمینان دارید؟';

  @override
  String get addSyllabus => 'افزودن سرفصل';

  @override
  String get enterSyllabusHint => 'سرفصل را وارد کنید';

  @override
  String get editClass => 'ویرایش کلاس';

  @override
  String get quizzes => 'آزمون‌ها';

  @override
  String get createNewQuiz => 'ساخت آزمون جدید';

  @override
  String get noQuizzesYet => 'هنوز هیچ آزمونی برنامه‌ریزی نشده است';

  @override
  String get tapToAddFirstQuiz =>
      'برای افزودن اولین آزمون، دکمه \'+\' را بزنید.';

  @override
  String get errorLoadingQuizzes => 'خطا در بارگذاری آزمون‌ها';

  @override
  String get errorLoadingClass => 'خطا در بارگذاری جزئیات کلاس';

  @override
  String get quizTitleLabel => 'عنوان آزمون*';

  @override
  String get enterQuizTitleHint => 'مثلاً: مرور فصل اول';

  @override
  String get quizDescriptionLabel => 'توضیحات (اختیاری)';

  @override
  String get enterQuizDescriptionHint => 'جزئیات اضافی درباره آزمون...';

  @override
  String get pickQuizDate => 'تاریخ آزمون را انتخاب کنید*';

  @override
  String get enterQuizTitleError => 'لطفاً عنوان آزمون را وارد کنید.';

  @override
  String get pickQuizDateError => 'لطفاً تاریخ آزمون را انتخاب کنید.';

  @override
  String get quizDetails => 'جزئیات آزمون';

  @override
  String get studentScores => 'نمرات دانش‌آموزان';

  @override
  String get saveResults => 'ذخیره نتایج';

  @override
  String get noStudentsInClassForQuiz =>
      'هیچ دانش‌آموزی در این کلاس ثبت‌نام نکرده تا نمره‌ای اختصاص یابد.';

  @override
  String get scoreLabel => 'نمره';

  @override
  String get errorLoadingQuizDetails =>
      'خطا: بارگذاری جزئیات آزمون امکان‌پذیر نیست.';

  @override
  String get errorLoadingQuizResults =>
      'خطا: بارگذاری نتایج آزمون امکان‌پذیر نیست.';

  @override
  String get errorSavingResults => 'خطا در ذخیره‌سازی نتایج';

  @override
  String get quizResultsSaved => 'نتایج آزمون با موفقیت ذخیره شد!';

  @override
  String get loadingScoreInput => 'در حال بارگذاری نمره...';

  @override
  String invalidScoreFormatFor(Object studentName) {
    return 'فرمت نمره نامعتبر برای $studentName.';
  }

  @override
  String get invalidNumberShort => 'نامعتبر';

  @override
  String get scorePositiveShort => '≥۰';

  @override
  String get title => 'عنوان';

  @override
  String get fixScoreErrors =>
      'لطفاً خطاهای نمرات را پیش از ذخیره‌سازی اصلاح کنید.';

  @override
  String get resultsSaved => 'نتایج آزمون با موفقیت ذخیره شد!';

  @override
  String get studentDetails => 'جزئیات دانش‌آموز';

  @override
  String get performanceSummary => 'خلاصه عملکرد';

  @override
  String get totalAttendance => 'حضور و غیاب';

  @override
  String get totalHomework => 'تکالیف';

  @override
  String get totalActivities => 'فعالیت‌های کلاسی';

  @override
  String get quizScores => 'نمرات آزمون';

  @override
  String get noQuizzesTaken => 'هیچ آزمونی گرفته نشده است.';

  @override
  String get errorLoadingStudentDetails => 'خطا در بارگذاری جزئیات دانش‌آموز.';

  @override
  String get errorLoadingActivities => 'خطا در بارگذاری فعالیت‌های دانش‌آموز.';

  @override
  String get errorLoadingQuizScores => 'خطا در بارگذاری نمرات آزمون.';

  @override
  String get studentNote => 'یادداشت دانش‌آموز';

  @override
  String get addStudentNote => 'افزودن یادداشت';

  @override
  String get editStudentNote => 'ویرایش یادداشت';

  @override
  String get enterStudentNoteHint => 'یادداشتی درباره دانش‌آموز وارد کنید...';

  @override
  String get noNoteForStudent =>
      'هیچ یادداشتی برای این دانش‌آموز ثبت نشده است.';

  @override
  String get unknownQuiz => 'آزمون ناشناخته';

  @override
  String basedOnNSessions(Object count) {
    return 'بر اساس $count جلسه ثبت‌شده';
  }

  @override
  String get addDescription => 'افزودن توضیحات';

  @override
  String get editDescription => 'ویرایش توضیحات';

  @override
  String get enterDescription => 'توضیحات را وارد کنید';

  @override
  String get inactiveClasses => 'کلاس‌های غیرفعال';

  @override
  String get classes => 'کلاس ها';

  @override
  String get upcomingQuiz => 'آزمون پیش‌رو';

  @override
  String get upcomingSession => 'جلسه پیش‌رو';

  @override
  String get today => 'امروز';

  @override
  String get tomorrow => 'فردا';

  @override
  String get editSessionDateTimeTitle => 'ویرایش تاریخ و زمان جلسه';

  @override
  String get selectNewDateTimePrompt =>
      'لطفاً تاریخ و زمان جدید جلسه را انتخاب کنید.';

  @override
  String get cancelButton => 'لغو';

  @override
  String get saveButton => 'ذخیره';

  @override
  String get sessionDateTimeUpdatedSuccess =>
      'تاریخ و زمان جلسه با موفقیت به‌روز شد!';

  @override
  String get errorUpdatingSessionDateTime =>
      'خطا در به‌روزرسانی تاریخ/زمان جلسه';

  @override
  String get editDateTooltip => 'ویرایش تاریخ و زمان';

  @override
  String get editQuizDateTimeTitle => 'ویرایش تاریخ و زمان آزمون';

  @override
  String get pickQuizDateTime => 'انتخاب تاریخ و زمان آزمون';

  @override
  String get quizDateTimeUpdatedSuccess =>
      'تاریخ و زمان آزمون با موفقیت به‌روز شد!';

  @override
  String get errorUpdatingQuizDateTime => 'خطا در به‌روزرسانی تاریخ/زمان آزمون';

  @override
  String get editDescriptionTooltip => 'ویرایش توضیحات';

  @override
  String get errorLoadingQuiz => 'خطا در بارگذاری جزئیات آزمون';

  @override
  String get confirmDeleteTitle => 'تأیید حذف';

  @override
  String get confirmDeleteSessionMessage =>
      'آیا از حذف این جلسه اطمینان دارید؟';

  @override
  String get delete => 'حذف';

  @override
  String get deleteSession => 'حذف جلسه';

  @override
  String get edit => 'ویرایش';

  @override
  String get confirmDeleteQuizMessage => 'آیا از حذف این آزمون اطمینان دارید؟';

  @override
  String get deleteQuiz => 'حذف آزمون';

  @override
  String get confirmDeleteStudentMessage =>
      'آیا از حذف این دانش‌آموز اطمینان دارید؟';

  @override
  String get deleteStudent => 'حذف دانش‌آموز';

  @override
  String get confirmDeleteClassMessage =>
      'آیا از حذف این کلاس اطمینان دارید؟ این کار باعث حذف تمام دانش‌آموزان، جلسات و آزمون‌های مربوط به آن خواهد شد.';

  @override
  String get deleteClass => 'حذف کلاس';

  @override
  String get maxScoreLabel => 'سقف نمره';

  @override
  String get enterMaxScoreHint => 'سقف نمره را وارد کنید (اختیاری)';

  @override
  String get scores => 'نمرات';

  @override
  String scoresFrom(int maxScore) {
    final intl.NumberFormat maxScoreNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String maxScoreString = maxScoreNumberFormat.format(maxScore);

    return 'نمره از $maxScoreString';
  }

  @override
  String get editMaxScore => 'ویرایش سقف نمره';

  @override
  String get addMaxScore => 'افزودن سقف نمره';

  @override
  String get enterMaxScore => 'وارد کردن سقف نمره';

  @override
  String get emptyClassesCaption =>
      'هیچ کلاسی ندارید.\nبرای افزودن کلاس جدید، دکمه + را بزنید.';

  @override
  String get selectFromCalendar => 'انتخاب از تقویم';

  @override
  String get selectFromSessionDates => 'انتخاب از تاریخ‌های جلسات';

  @override
  String get noScheduledSessions => 'جلسه زمان‌بندی‌شده‌ای یافت نشد.';

  @override
  String get selectSession => 'انتخاب جلسه';

  @override
  String get share => 'اشتراک‌گذاری';

  @override
  String get shareAsText => 'اشتراک‌گذاری به‌صورت متن';

  @override
  String get shareAsImage => 'اشتراک‌گذاری به‌صورت تصویر';

  @override
  String get imageCaptureFailed => 'ثبت تصویر ناموفق بود.';

  @override
  String get shareFailed => 'اشتراک‌گذاری ناموفق بود';

  @override
  String get session => 'جلسه';

  @override
  String get classLabel => 'کلاس';

  @override
  String get className => 'نام کلاس';

  @override
  String get subject => 'موضوع';

  @override
  String get grade => 'پایه';

  @override
  String get quiz => 'آزمون';

  @override
  String get classDetail => 'جزئیات کلاس';

  @override
  String get minutes => 'دقیقه';

  @override
  String get notSet => 'تنظیم نشده';

  @override
  String get shareClass => 'اشتراک‌گذاری کلاس';

  @override
  String get pickSessionDateError => 'لطفاً یک تاریخ برای جلسه انتخاب کنید.';

  @override
  String get welcomeTitle => 'خوش آمدید به ';

  @override
  String get welcomeAppName => 'تیچر میت!';

  @override
  String get welcomeDescription =>
      'همراه شما برای مدیریت کلاس‌ها، دانش‌آموزان، جلسات و آزمون‌ها — همه در یک جا.\n\nزندگی تدریس خود را سازماندهی کنید، پیشرفت را بدون دردسر پیگیری کنید و بیشتر بر چیزی تمرکز کنید که اهمیت دارد: آموزش و الهام‌بخشی.\n\nبیایید هر کلاس را به فرصتی ارزشمند تبدیل کنیم! 🎓✨';

  @override
  String get iAgreeTo => 'مواففت با ';

  @override
  String get termsTitle => 'شرایط و ضوابط';

  @override
  String get termsDialogContent =>
      'با استفاده از این اپلیکیشن، شما با شرایط استفاده زیر موافقت می‌کنید. لطفاً آن‌ها را با دقت مطالعه کنید.\n\n۱. ذخیره‌سازی محلی داده‌ها\nتمام اطلاعاتی که در تیچر میت وارد می‌کنید — شامل جزئیات کلاس، اطلاعات دانش‌آموزان، جلسات و آزمون‌ها — فقط به صورت محلی روی دستگاه شما ذخیره می‌شود.\nما هیچ‌گونه داده‌ای را جمع‌آوری، منتقل یا ذخیره نمی‌کنیم. مسئولیت پشتیبان‌گیری و حفاظت از داده‌ها کاملاً بر عهده‌ی شماست.\n\n۲. مسئولیت کاربر\nشما به عنوان کاربر تیچر میت متعهد می‌شوید که:\n• فقط از اپلیکیشن برای اهداف آموزشی و قانونی استفاده کنید.\n• اطمینان حاصل کنید که اطلاعات وارد شده مطابق قوانین کشور و سیاست‌های مؤسسه باشد.\n• مسئول کامل نگهداری، امنیت و در صورت نیاز، حذف اطلاعات خود باشید.\nما مسئولیتی در قبال از دست رفتن، خرابی یا سوء‌استفاده از داده‌های شما نداریم.\n\n۳. بدون حساب کاربری یا فضای ابری\nبرای استفاده از تیچر میت نیاز به ایجاد حساب کاربری یا اتصال به اینترنت ندارید. در حال حاضر همگام‌سازی ابری یا پشتیبان‌گیری آنلاین وجود ندارد. تمام اطلاعات فقط روی دستگاه شما ذخیره می‌شود و برای تیم توسعه‌دهنده قابل دسترسی نیست.\n\n۴. محدودیت مسئولیت\nتیچر میت «همان‌گونه که هست» ارائه می‌شود و هیچ ضمانتی ندارد. ما مسئول هیچ‌گونه خسارت مستقیم یا غیرمستقیم ناشی از استفاده یا ناتوانی در استفاده از اپ نیستیم.\nاین شامل از دست رفتن داده‌ها، گزارش‌گیری نادرست یا جلسات از دست رفته می‌شود.\n\n۵. مالکیت معنوی\nتمام طراحی‌ها، لوگوها و رابط کاربری اپ متعلق به تیم توسعه تیچر میت است. کپی‌برداری یا بازتوزیع آن بدون مجوز کتبی ممنوع است.\n\n۶. استفاده‌های ممنوع\nشما توافق می‌کنید که:\n• کد برنامه را مهندسی معکوس یا تغییر ندهید.\n• اپ را برای فروش یا توزیع تجاری استفاده نکنید.\n• اطلاعات حساس یا ممنوعه وارد اپ نکنید.\n\n۷. بروزرسانی‌ها و تغییرات\nممکن است برای بهبود عملکرد یا افزودن ویژگی‌ها، اپ به‌روزرسانی شود. استفاده‌ی شما از اپ به‌عنوان پذیرش این تغییرات تلقی می‌شود.\n\n۸. قطع خدمات\nدر صورت نقض این شرایط، ممکن است دسترسی شما به اپ محدود یا قطع شود. همچنین می‌توانید هر زمان که خواستید، اپ را حذف کرده و استفاده را متوقف کنید.\n\n۹. قانون حاکم\nاین شرایط بر اساس قوانین محل زندگی شما تنظیم می‌شود. هرگونه اختلاف بر اساس این قوانین بررسی خواهد شد.\n\nبا ادامه استفاده از تیچر میت، شما تأیید می‌کنید که این شرایط را خوانده، درک کرده و پذیرفته‌اید.';

  @override
  String get close => 'بستن';

  @override
  String get getStarted => 'شروع';

  @override
  String get createQuiz => 'ساخت آزمون';

  @override
  String get enrollStudent => 'ثبت‌نام دانش‌آموز';

  @override
  String get scheduleSessionBtn => 'برنامه‌ریزی جلسه';

  @override
  String get beta => 'بتا';

  @override
  String get shareSession => 'اشتراک‌گذاری جلسه';

  @override
  String get shareQuiz => 'اشتراک‌گذاری آزمون';

  @override
  String get quizResults => 'نتایج آزمون';

  @override
  String get themeModeTitle => 'حالت تم';

  @override
  String get themeColorTitle => 'رنگ تم';

  @override
  String themeColor(String theme_color) {
    String _temp0 = intl.Intl.selectLogic(theme_color, {
      'blue': 'آبی',
      'yellow': 'زرد',
      'pink': 'صورتی',
      'purple': 'بنفش',
      'green': 'سبز',
      'red': 'قرمز',
      'other': 'رنگ تم',
    });
    return '$_temp0';
  }

  @override
  String get addModeSingle => 'دانش‌آموز تکی';

  @override
  String get addModeMultiple => 'چند دانش‌آموز';

  @override
  String get calendar => 'تقویم';

  @override
  String calendarType(String calendar_type) {
    String _temp0 = intl.Intl.selectLogic(calendar_type, {
      'gregorian': 'میلادی',
      'persian': 'شمسی',
      'other': 'نوع تقویم',
    });
    return '$_temp0';
  }

  @override
  String get student => 'دانش‌آموز';

  @override
  String get studentReport => 'گزارش دانش‌آموز';

  @override
  String get shareStudentReport => 'اشتراک‌گذاری گزارش دانش‌آموز';

  @override
  String get age => 'سن';

  @override
  String get background => 'پیش زمینه';

  @override
  String get addAge => 'افزودن سن';

  @override
  String get addBackground => 'افزودن پیش‌زمینه';

  @override
  String get addStudentAge => 'افزودن سن دانش‌آموز';

  @override
  String get editStudentAge => 'ویرایش سن دانش‌آموز';

  @override
  String get addStudentBackground => 'افزودن پیش‌زمینه دانش‌آموز';

  @override
  String get editStudentBackground => 'ویرایش پیش‌زمینه دانش‌آموز';

  @override
  String get enterStudentAgeHint => 'سن دانش‌آموز را وارد کنید';

  @override
  String get enterStudentBackgroundHint => 'پیش‌زمینهٔ دانش‌آموز را وارد کنید';

  @override
  String get all => 'همه';

  @override
  String get noSessionsFoundForFilter => 'جلسه‌ای برای این فیلتر یافت نشد.';

  @override
  String get tryDifferentFilter =>
      'فیلتر دیگری را امتحان کنید یا برنامه خود را بررسی کنید.';
}

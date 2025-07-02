import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teacher_mate/domain/data_models/student_report_model.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart'; // Your Drift Class, Session, Quiz models
import 'package:teacher_mate/l10n/app_localizations.dart'; // Your AppLocalizations
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';

class ShareService {
  final TMDateFormatter formatter;

  ShareService(this.formatter);

  final ScreenshotController _screenshotController = ScreenshotController();

  Widget _buildAppSign(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        Image.asset('assets/icon/icon.png', width: 35, height: 35),
        const SizedBox(width: 4),
        Text(
          AppLocalizations.of(context)!.teacherMate,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // --- Helper Widgets for Displaying Data (for Screenshots) ---

  Widget _buildSessionDisplayWidget(
    Session sessionData,
    String classTitle,
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    String dateFormatted = formatter.formatFull(sessionData.date);

    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$classTitle ${localizations.session} ${sessionData.number}',

              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('${localizations.dateTitle}: $dateFormatted'),
            const SizedBox(height: 4),
            Text('${localizations.status}: ${sessionData.status.name}'),

            if (sessionData.homework != null &&
                sessionData.homework!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  '${localizations.homework}: ${sessionData.homework}',
                ),
              ),
            if (sessionData.note != null && sessionData.note!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text('${localizations.notes}: ${sessionData.note}'),
              ),
            SizedBox(height: 16),
            _buildAppSign(context),
          ],
        ),
      ),
    );
  }

  Widget _buildClassDisplayWidget(Class classData, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    String dateFormatted = formatter.formatFull(classData.firstSession);

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classData.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  classData.isActive
                      ? Icons.check_circle_outline_rounded
                      : Icons.highlight_off_rounded,
                  size: 20,
                  color:
                      classData.isActive
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 4),
                Text(
                  classData.isActive
                      ? localizations.active
                      : localizations.inactive,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                        classData.isActive
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoChip(
                  context,
                  Icons.hourglass_bottom,
                  '${classData.duration} ${localizations.minutes}',
                  localizations.durationPerSession,
                ),
                _buildInfoChip(
                  context,
                  Icons.format_list_numbered_rounded,
                  '${classData.sessionCount}',
                  localizations.totalSessions,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.flag_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${localizations.startsOn}: $dateFormatted',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            if (classData.description != null &&
                classData.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${localizations.description}: ${classData.description!}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),

            if (classData.syllabus != null && classData.syllabus!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.syllabusOutline,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      classData.syllabus!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            _buildAppSign(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizDisplayWidget(
    Quiz quizData,
    String classTitle,
    BuildContext context,
    List<Student>? students,
    List<QuizResult>? results,
  ) {
    final localizations = AppLocalizations.of(context)!;
    String dateFormatted = formatter.formatFull(quizData.date);

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$classTitle • ${quizData.title}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('${localizations.dateTitle}: $dateFormatted'),
            if (quizData.maxScore != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  '${localizations.maxScoreLabel}: ${quizData.maxScore}',
                ),
              ),
            if (quizData.description != null &&
                quizData.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  '${localizations.description}: ${quizData.description}',
                ),
              ),
            if (students != null && results != null && results.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.quizResults,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (
                              int index = 0;
                              index < students.length;
                              index++
                            ) ...[
                              Builder(
                                builder: (context) {
                                  final student = students[index];
                                  final result =
                                      results
                                          .where(
                                            (r) => r.studentId == student.id,
                                          )
                                          .firstOrNull;
                                  final score = result?.score.toString() ?? '-';

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          student.name,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        score,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              if (index < students.length - 1)
                                const Divider(height: 16),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            _buildAppSign(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentReportDisplayWidget(
    StudentReport studentReport,
    BuildContext context,
  ) {
    final localizations = AppLocalizations.of(context)!;
    final student = studentReport.student;
    final quizzes = studentReport.quizzes;
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(student.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoChip(
                  context,
                  Icons.star_outline,
                  '${studentReport.attendanceCount}',
                  localizations.attendance,
                ),
                _buildInfoChip(
                  context,
                  Icons.menu_book_outlined,
                  '${studentReport.homeworkCount}',
                  localizations.homework,
                ),
                _buildInfoChip(
                  context,
                  Icons.check_circle_outline,
                  '${studentReport.activityCount}',
                  localizations.totalActivities,
                ),
              ],
            ),
            if (quizzes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.quizResults,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Card(
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            for (
                              int index = 0;
                              index < quizzes.length;
                              index++
                            ) ...[
                              Builder(
                                builder: (context) {
                                  final q = quizzes[index];

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 3, // Give more space to the title

                                        child: Text(
                                          q.quiz.title,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2, // Give more space to the title

                                        child: Text(
                                          formatter.formatCompact(q.quiz.date),
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1, // Give more space to the title
                                        child: Text(
                                          "${q.result.score}${q.quiz.maxScore != null ? '/${q.quiz.maxScore}' : ''}",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              if (index < quizzes.length - 1)
                                const Divider(height: 16),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 16),
            _buildAppSign(context),
          ],
        ),
      ),
    );
  }

  // --- Text Formatting ---

  String _formatSessionAsText(
    Session sessionData,
    String classTitle,
    AppLocalizations localizations,
  ) {
    String dateFormatted = formatter.formatFull(sessionData.date);

    return '''
📘 $classTitle ${localizations.session} ${sessionData.number}
📅 ${localizations.dateTitle}: $dateFormatted
📌 ${localizations.status}: ${sessionData.status.name}
${sessionData.homework != null && sessionData.homework!.isNotEmpty ? '📝 ${localizations.homework}: ${sessionData.homework}\n' : ''}${sessionData.note != null && sessionData.note!.isNotEmpty ? '🗒️ ${localizations.notes}: ${sessionData.note}\n' : ''}
👨‍🏫 ${localizations.teacherMate}''';
  }

  String _formatClassAsText(Class classData, AppLocalizations localizations) {
    String dateFormatted = formatter.formatFull(classData.firstSession);

    return '''🏫 ${localizations.classDetail}
📌 ${localizations.title}: ${classData.title}
📅 ${localizations.startsOn}: $dateFormatted
⏱️ ${localizations.sessionDuration}: ${classData.duration} ${localizations.minutes}
📚 ${localizations.sessions}: ${classData.sessionCount}
${classData.syllabus != null && classData.syllabus!.isNotEmpty ? '🧾 ${localizations.syllabusOutline}: ${classData.syllabus}\n' : ''}${classData.description != null && classData.description!.isNotEmpty ? '📝 ${localizations.description}: ${classData.description}\n' : ''}
👨‍🏫 ${localizations.teacherMate}''';
  }

  String _formatQuizAsText(
    Quiz quizData,
    String classTitle,
    AppLocalizations localizations,
    List<Student>? students,
    List<QuizResult>? results,
  ) {
    String dateFormatted = formatter.formatFull(quizData.date);

    String quizResults = '';

    if (results != null && results.isNotEmpty) {
      quizResults += "${localizations.quizResults}\n";
      for (var student in students!) {
        String result;
        try {
          result =
              results
                  .firstWhere((r) => r.studentId == student.id)
                  .score
                  .toString();
        } catch (e) {
          result = '-'; // no match found
        }

        quizResults += "${student.name}: $result \n";
      }
    }

    return '''
🧪 $classTitle • ${quizData.title}
📅 ${localizations.dateTitle}: $dateFormatted
${quizData.maxScore != null ? '🏆 ${localizations.maxScoreLabel}: ${quizData.maxScore}\n' : ''}${quizData.description != null && quizData.description!.isNotEmpty ? '📝 ${localizations.description}: ${quizData.description}\n' : ''}
${quizResults.isNotEmpty ? quizResults : ''}
👨‍🏫 ${localizations.teacherMate}''';
  }

  String _formatStudentReportAsText(
    StudentReport studentReport,
    AppLocalizations localizations,
  ) {
    final student = studentReport.student;
    final quizzes = studentReport.quizzes;
    String quizzesString = '';
    if (quizzes.isNotEmpty) {
      quizzesString += "📊 ${localizations.quizScores}\n";
      for (var q in quizzes) {
        quizzesString +=
            "- ${q.quiz.title} • ${formatter.formatCompact(q.quiz.date)}: ${q.result.score}${q.quiz.maxScore != null ? '/${q.quiz.maxScore}' : ''}\n";
      }
    }

    return '''
🧑‍🎓 ${student.name}
📅 ${localizations.attendance}: ${studentReport.attendanceCount}
📝 ${localizations.homework}: ${studentReport.homeworkCount}
📚 ${localizations.totalActivities}: ${studentReport.activityCount}\n
$quizzesString
👨‍🏫 ${localizations.teacherMate}''';
  }

  // --- Core Sharing Logic ---

  Future<void> _shareTextData(String text, String subject) async {
    await SharePlus.instance.share(ShareParams(text: text, subject: subject));
  }

  Future<void> _shareWidgetAsImage(
    BuildContext context,
    Widget widgetToCapture,
    String subject,
    String fileNamePrefix,
  ) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    try {
      final Uint8List imageBytes = await _screenshotController
          .captureFromLongWidget(
            InheritedTheme.captureAll(
              context,
              Material(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Directionality(
                  textDirection: Directionality.of(context),
                  child: widgetToCapture,
                ),
              ),
            ),
            delay: const Duration(milliseconds: 300),
            context: context,
            constraints: BoxConstraints(maxWidth: 600),
            pixelRatio: pixelRatio,
          );

      final directory = await getTemporaryDirectory();
      final imagePath =
          await File(
            '${directory.path}/$fileNamePrefix-${DateTime.now().millisecondsSinceEpoch}.png',
          ).create();
      await imagePath.writeAsBytes(imageBytes);

      final params = ShareParams(
        subject: subject,
        files: [XFile(imagePath.path)],
      );

      await SharePlus.instance.share(params);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context)!.shareFailed}: $e'),
        ),
      );
    }
  }

  Future<void> _showShareOptionsDialog(
    BuildContext context, {
    required String itemTitle,
    required String textData,
    required Widget Function(BuildContext captureContext) buildWidgetToCapture,
    required String fileNamePrefix,
    required String dialogTitle,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(dialogTitle),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 60,
                child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                        bottom: Radius.circular(4),
                      ),
                    ),
                  ),
                  child: Text(localizations.shareAsText),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    _shareTextData(textData, itemTitle);
                  },
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 60,
                child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(4),
                        bottom: Radius.circular(16),
                      ),
                    ),
                  ),
                  child: Text(localizations.shareAsImage),
                  onPressed: () {
                    Navigator.pop(dialogContext);

                    final widget = buildWidgetToCapture(context);
                    _shareWidgetAsImage(
                      context,
                      widget,
                      itemTitle,
                      fileNamePrefix,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Public API ---

  Future<void> shareSession(
    Session sessionData,
    String classTitle,
    BuildContext context,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    await _showShareOptionsDialog(
      context,
      dialogTitle: localizations.shareSession,
      itemTitle: '${localizations.session}: ${sessionData.number}',
      textData: _formatSessionAsText(sessionData, classTitle, localizations),
      buildWidgetToCapture:
          (captureContext) => _buildSessionDisplayWidget(
            sessionData,
            classTitle,
            captureContext,
          ),
      fileNamePrefix: 'session-${sessionData.id}',
    );
  }

  Future<void> shareClass(Class classData, BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    await _showShareOptionsDialog(
      context,
      dialogTitle: localizations.shareClass,
      itemTitle: '${localizations.classLabel}: ${classData.title}',
      textData: _formatClassAsText(classData, localizations),
      buildWidgetToCapture:
          (captureContext) =>
              _buildClassDisplayWidget(classData, captureContext),
      fileNamePrefix: 'class-${classData.id}',
    );
  }

  Future<void> shareQuiz(
    Quiz quizData,
    String classTitle,
    BuildContext context,
    List<Student>? students,
    List<QuizResult>? results,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    await _showShareOptionsDialog(
      dialogTitle: localizations.shareQuiz,
      context,
      itemTitle: '${localizations.quiz}: ${quizData.title}',
      textData: _formatQuizAsText(
        quizData,
        classTitle,
        localizations,
        students,
        results,
      ),
      buildWidgetToCapture:
          (captureContext) => _buildQuizDisplayWidget(
            quizData,
            classTitle,
            captureContext,
            students,
            results,
          ),
      fileNamePrefix: 'quiz-${quizData.id}',
    );
  }

  Future<void> shareStudentReport(
    StudentReport studentReport,
    BuildContext context,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    await _showShareOptionsDialog(
      context,
      dialogTitle: localizations.shareStudentReport,
      itemTitle: '${localizations.student}: ${studentReport.student.name}',
      textData: _formatStudentReportAsText(studentReport, localizations),
      buildWidgetToCapture:
          (captureContext) =>
              _buildStudentReportDisplayWidget(studentReport, captureContext),
      fileNamePrefix: 'student-${studentReport.student.id}',
    );
  }
}

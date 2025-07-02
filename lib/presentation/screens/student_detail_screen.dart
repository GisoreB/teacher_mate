import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/students_providers.dart';
import 'package:teacher_mate/applications/state_management/student_activities_providers.dart';
import 'package:teacher_mate/applications/state_management/quiz_results_providers.dart';
import 'package:teacher_mate/applications/state_management/quizzes_providers.dart';
import 'package:teacher_mate/domain/data_models/quiz_with_result_model.dart';
import 'package:teacher_mate/domain/data_models/student_report_model.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/share_service.dart';
import 'package:teacher_mate/presentation/widgets/detail_row_widget.dart';

class StudentDetailScreen extends ConsumerWidget {
  final int studentId;

  const StudentDetailScreen({super.key, required this.studentId});

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          avatar: Icon(
            icon,
            size: 20,
            color: iconColor ?? Theme.of(context).colorScheme.primary,
          ),
          label: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.secondaryContainer.withValues(alpha: 0.7),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
            const SizedBox(width: 10),
          ],
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String message, [
    String? subMessage,
  ]) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showEditStudentNoteDialog(
    BuildContext context,
    WidgetRef ref,
    int studentId,
    String? currentNote,
  ) async {
    final noteController = TextEditingController(text: currentNote);
    final formKey = GlobalKey<FormState>();
    final localizations = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            currentNote == null || currentNote.isEmpty
                ? localizations.addStudentNote
                : localizations.editStudentNote,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: noteController,
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: localizations.enterStudentNoteHint,
                    // Needs localization
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(localizations.save),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newNote = noteController.text.trim();
                  ref
                      .read(studentRepositoryProvider.notifier)
                      .updateNote(studentId, newNote.isEmpty ? null : newNote);
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditStudentAgeDialog(
    BuildContext context,
    WidgetRef ref,
    int studentId,
    String? currentAge,
  ) async {
    final ageController = TextEditingController(text: currentAge);
    final formKey = GlobalKey<FormState>();
    final localizations = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            currentAge == null || currentAge.isEmpty
                ? localizations.addStudentAge
                : localizations.editStudentAge,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: ageController,
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: localizations.enterStudentAgeHint,
                    // Needs localization
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(localizations.save),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newAgeText = ageController.text.trim();
                  final int? newAgeInt =
                      newAgeText.isEmpty ? null : int.tryParse(newAgeText);
                  ref
                      .read(studentRepositoryProvider.notifier)
                      .updateAge(studentId, newAgeInt);
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditStudentBackgroundDialog(
    BuildContext context,
    WidgetRef ref,
    int studentId,
    String? currentBackground,
  ) async {
    final backgroundController = TextEditingController(text: currentBackground);
    final formKey = GlobalKey<FormState>();
    final localizations = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            currentBackground == null || currentBackground.isEmpty
                ? localizations.addStudentBackground
                : localizations.editStudentBackground,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: backgroundController,
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: localizations.enterStudentBackgroundHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.cancel),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(localizations.save),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newBackground = backgroundController.text.trim();
                  ref
                      .read(studentRepositoryProvider.notifier)
                      .updateBackground(
                        studentId,
                        newBackground.isEmpty ? null : newBackground,
                      );
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.confirmDeleteTitle),
            content: Text(
              AppLocalizations.of(context)!.confirmDeleteStudentMessage,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(AppLocalizations.of(context)!.delete),
              ),
            ],
          ),
    );
    if (confirmed == true && context.mounted) {
      context.pop();
      ref.read(studentRepositoryProvider.notifier).deleteStudent(studentId);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final studentAsync = ref.watch(singleStudentProvider(studentId));
    final activitiesAsync = ref.watch(activitiesForStudentProvider(studentId));
    final quizResultsAsync = ref.watch(
      quizResultsForStudentProvider(studentId),
    );
    final quizzesAsync = ref.watch(allQuizzesProvider);
    final formatter = ref.watch(tMDateFormatterProvider);
    final shareService = ShareService(formatter);

    //create student report to for share student option
    //Todo: it has to be a provider!
    late StudentReport report;
    studentAsync.whenData((s) {
      final List allQuizzes = quizzesAsync.value ?? [];
      final List quizResults = quizResultsAsync.value ?? [];
      final allActivities = activitiesAsync.value ?? [];

      final attendanceCount = allActivities.where((a) => a.attendance).length;
      final homeworkCount = allActivities.where((a) => a.homework).length;
      final activityCount = allActivities.where((a) => a.classActivity).length;

      final List<QuizWithResult> quizzesWithResult =
          quizResults.map((r) {
            final quiz = allQuizzes.firstWhere((q) => q.id == r.quizId);
            return QuizWithResult(quiz: quiz, result: r);
          }).toList();

      report = StudentReport(
        student: s,
        attendanceCount: attendanceCount,
        homeworkCount: homeworkCount,
        activityCount: activityCount,
        quizzes: quizzesWithResult,
      );
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              shareService.shareStudentReport(report, context);
            },
            icon: Icon(Icons.share),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation(context, ref);
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.delete,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ],
          ),
        ],
        title: studentAsync.when(
          data: (student) => Text(student.name),
          loading: () => Text(localizations.loading),
          error: (_, __) => Text(localizations.studentDetails),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Student Info Card ---
            studentAsync.when(
              data:
                  (student) => Card(
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (student.age != null)
                            DetailRow(
                              title: AppLocalizations.of(context)!.age,
                              value: student.age.toString(),
                              icon: Icons.timelapse,
                              action: IconButton(
                                onPressed:
                                    () => _showEditStudentAgeDialog(
                                      context,
                                      ref,
                                      studentId,
                                      student.age.toString(),
                                    ),
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),

                          if (student.background != null &&
                              student.background!.isNotEmpty)
                            DetailRow(
                              title: AppLocalizations.of(context)!.background,
                              value: student.background!,
                              icon: Icons.description,
                              action: IconButton(
                                onPressed:
                                    () => _showEditStudentBackgroundDialog(
                                      context,
                                      ref,
                                      studentId,
                                      student.background,
                                    ),
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          if (student.note != null && student.note!.isNotEmpty)
                            DetailRow(
                              title: AppLocalizations.of(context)!.note,
                              value: student.note!,
                              icon: Icons.subject,
                              action: IconButton(
                                onPressed:
                                    () => _showEditStudentNoteDialog(
                                      context,
                                      ref,
                                      studentId,
                                      student.note,
                                    ),
                                icon: Icon(
                                  Icons.edit,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          if (student.age == null)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed:
                                    () => _showEditStudentAgeDialog(
                                      context,
                                      ref,
                                      studentId,
                                      null,
                                    ),
                                child: Text(
                                  AppLocalizations.of(context)!.addAge,
                                ),
                              ),
                            ),
                          if (student.background == null ||
                              student.background!.isEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed:
                                    () => _showEditStudentBackgroundDialog(
                                      context,
                                      ref,
                                      studentId,
                                      student.background,
                                    ),
                                child: Text(
                                  AppLocalizations.of(context)!.addBackground,
                                ),
                              ),
                            ),
                          if (student.note == null || student.note!.isEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed:
                                    () => _showEditStudentNoteDialog(
                                      context,
                                      ref,
                                      studentId,
                                      student.note,
                                    ),
                                child: Text(
                                  AppLocalizations.of(context)!.addNote,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (e, _) => _buildEmptyState(
                    context,
                    Icons.person_off_outlined,
                    localizations.errorLoadingStudentDetails,
                    e.toString(),
                  ),
            ),
            const SizedBox(height: 16),

            // --- Performance Summary Card ---
            _buildSectionTitle(
              context,
              localizations.performanceSummary,
              icon: Icons.assessment_outlined,
            ),
            activitiesAsync.when(
              data: (activities) {
                final attendanceCount =
                    activities.where((a) => a.attendance).length;
                final homeworkCount =
                    activities.where((a) => a.homework).length;
                final activityCount =
                    activities.where((a) => a.classActivity).length;
                final totalSessionsRecorded =
                    activities.map((a) => a.sessionId).toSet().length;

                return Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoChip(
                              context,
                              icon: Icons.check_circle_outline,
                              value: '$attendanceCount',
                              label: localizations.totalAttendance,
                            ),
                            _buildInfoChip(
                              context,
                              icon: Icons.menu_book_outlined,
                              value: '$homeworkCount',
                              label: localizations.totalHomework,
                            ),
                            _buildInfoChip(
                              context,
                              icon: Icons.star_border_outlined,
                              value: '$activityCount',
                              label: localizations.totalActivities,
                            ),
                          ],
                        ),
                        if (totalSessionsRecorded > 0) ...[
                          const SizedBox(height: 12),
                          Text(
                            localizations.basedOnNSessions(
                              totalSessionsRecorded.toString(),
                            ),
                            // Needs localization
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (e, _) => _buildEmptyState(
                    context,
                    Icons.error_outline,
                    localizations.errorLoadingActivities,
                    e.toString(),
                  ),
            ),
            const SizedBox(height: 16),

            // --- Quiz Scores Card ---
            _buildSectionTitle(
              context,
              localizations.quizScores,
              icon: Icons.quiz_outlined,
            ),
            quizResultsAsync.when(
              data: (results) {
                if (results.isEmpty) {
                  return _buildEmptyState(
                    context,
                    Icons.quiz,
                    localizations.noQuizzesTaken,
                  );
                }

                return quizzesAsync.when(
                  data: (quizzes) {
                    // Create a map of quizId to quiz title for easy lookup
                    final quizTitles = {for (var q in quizzes) q.id: q.title};
                    final quizDates = {for (var q in quizzes) q.id: q.date};
                    final quizMaxScores = {
                      for (var q in quizzes) q.id: q.maxScore,
                    };

                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: ListView.separated(

                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final result = results[index];
                          final quizTitle =
                              quizTitles[result.quizId] ??
                              localizations.unknownQuiz; // Needs localization
                          final quizDate = quizDates[result.quizId];
                          final formattedDate =
                              quizDate != null
                                  ? formatter.formatFull(quizDate)
                                  : '';
                          final String fromMaxScore =
                              quizMaxScores[result.quizId] != null
                                  ? "/${quizMaxScores[result.quizId]}"
                                  : "";
                          return ListTile(
                            leading: Icon(
                              Icons.assignment_turned_in_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              quizTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              formattedDate,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            trailing: Text(
                              result.score
                                      .toStringAsFixed(1)
                                      .replaceAll(RegExp(r'\.0$'), '') +
                                  fromMaxScore,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => Divider(
                          color: Theme.of(context).colorScheme.surface,
                          thickness: 2,
                        ),
                      ),
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (e, _) => _buildEmptyState(
                        context,
                        Icons.error_outline,
                        localizations.errorLoadingQuizzes,
                        e.toString(),
                      ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error:
                  (e, _) => _buildEmptyState(
                    context,
                    Icons.error_outline,
                    localizations.errorLoadingQuizScores,
                    e.toString(),
                  ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

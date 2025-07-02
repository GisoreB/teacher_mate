import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/classes_providers.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/quizzes_providers.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/applications/state_management/students_providers.dart';
import 'package:teacher_mate/applications/state_management/quiz_results_providers.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/share_service.dart';
import 'package:teacher_mate/presentation/widgets/detail_row_widget.dart';

class QuizDetailScreen extends ConsumerStatefulWidget {
  final int quizId;

  const QuizDetailScreen({super.key, required this.quizId});

  @override
  ConsumerState<QuizDetailScreen> createState() => _QuizDetailScreenState();
}

class _QuizDetailScreenState extends ConsumerState<QuizDetailScreen> {
  Map<int, TextEditingController> _scoreControllers =
      {}; // studentId -> Controller
  bool _areControllersInitialized = false;
  final _formKey = GlobalKey<FormState>(); // Form key for score validation

  @override
  void dispose() {
    for (var controller in _scoreControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _synchronizeScoreControllers(
    List<Student> students,
    List<QuizResult> existingResults,
  ) {
    final newControllers = <int, TextEditingController>{};
    bool changed = false;

    for (var student in students) {
      final existingResult = existingResults.firstWhereOrNull(
        (r) => r.studentId == student.id,
      );
      if (_scoreControllers.containsKey(student.id)) {
        newControllers[student.id] = _scoreControllers[student.id]!;
      } else {
        newControllers[student.id] = TextEditingController(
          text:
              existingResult?.score
                  .toStringAsFixed(1)
                  .replaceAll(RegExp(r'\.0$'), '') ??
              '', // Format score, remove .0
        );
        changed = true;
      }
    }

    if (_scoreControllers.keys.any((id) => !newControllers.containsKey(id)) ||
        _scoreControllers.length != newControllers.length) {
      changed = true;
    }

    if (changed) {
      final oldControllers = Map.from(_scoreControllers);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          oldControllers.forEach((studentId, controller) {
            if (!newControllers.containsKey(studentId)) {
              controller.dispose();
            }
          });
          setState(() {
            _scoreControllers = newControllers;
            _areControllersInitialized = true;
          });
        }
      });
      return true;
    } else if (!_areControllersInitialized && students.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _scoreControllers = newControllers;
            _areControllersInitialized = true;
          });
        }
      });
      return true;
    }
    if (students.isNotEmpty && !_areControllersInitialized) {
      _areControllersInitialized = true;
    }
    return false;
  }

  void _saveResults(Quiz quizData, List<Student> students) async {
    final localizations = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      // Validate all score fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.fixScoreErrors),
          behavior: SnackBarBehavior.floating,
        ), // Needs localization
      );
      return;
    }
    for (var student in students) {
      final controller = _scoreControllers[student.id];
      if (controller != null) {
        final scoreText = controller.text.trim();
        if (scoreText.isNotEmpty) {
          final resultCompanion = QuizResultsCompanion(
            studentId: drift.Value(student.id),
            quizId: drift.Value(widget.quizId),
            score: drift.Value(double.parse(scoreText)),
          );
          ref
              .read(quizResultRepositoryProvider.notifier)
              .upsertResult(companion: resultCompanion);
        }
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localizations.resultsSaved),
        behavior: SnackBarBehavior.floating,
      ), // Needs localization
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String message,
    String? subMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }

  Future<void> _showEditDescriptionDialog(
    BuildContext context,
    WidgetRef ref,
    int quizId,
    String? currentDescription,
  ) async {
    final descriptionController = TextEditingController(
      text: currentDescription,
    );
    final formKey = GlobalKey<FormState>();
    final localizations = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            currentDescription == null || currentDescription.isEmpty
                ? localizations.addDescription
                : localizations.editDescription,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: descriptionController,
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: localizations.enterDescription,
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
                  final newDescription = descriptionController.text.trim();
                  ref
                      .read(quizRepositoryProvider.notifier)
                      .updateDescription(quizId, newDescription);
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditMaxScoreDialog(
    BuildContext context,
    WidgetRef ref,
    String? currentMaxScore,
  ) async {
    final maxScoreController = TextEditingController(text: currentMaxScore);
    final formKey = GlobalKey<FormState>();
    final localizations = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            currentMaxScore == null || currentMaxScore.isEmpty
                ? localizations.addMaxScore
                : localizations.editMaxScore,
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: maxScoreController,
                autofocus: true,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: localizations.enterMaxScore,
                  border: const OutlineInputBorder(),
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
                  final newMaxScore = maxScoreController.text.trim();
                  ref
                      .read(quizRepositoryProvider.notifier)
                      .updateMaxScore(widget.quizId, newMaxScore);
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditQuizDateTimeDialog(
    BuildContext context,
    WidgetRef ref,
    int currentQuizId,
    DateTime initialDateTime,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final newDateTime = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext dialogContext) {
        return _EditQuizDateTimeDialogContent(
          initialDateTime: initialDateTime,
          localizations: localizations,
        );
      },
    );

    if (newDateTime != null && context.mounted) {
      try {
        await ref
            .read(quizRepositoryProvider.notifier)
            .updateDate(currentQuizId, newDateTime);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.quizDateTimeUpdatedSuccess),
            behavior: SnackBarBehavior.floating,
          ), // Needs localization
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${localizations.errorUpdatingQuizDateTime}: $e'),
            behavior: SnackBarBehavior.floating,
          ), // Needs localization
        );
      }
    }
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.confirmDeleteTitle),
            content: Text(
              AppLocalizations.of(context)!.confirmDeleteQuizMessage,
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
      ref.read(quizRepositoryProvider.notifier).delete(widget.quizId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final quizAsync = ref.watch(singleQuizProvider(widget.quizId));
    final formatter = ref.watch(tMDateFormatterProvider);
    final shareService = ShareService(formatter);

    late List<Student>? students;
    late List<QuizResult>? results;
    quizAsync.whenData((q) {
      students = ref.watch(studentsByClassProvider(q.classId)).value;
      results = ref.watch(resultsByQuizProvider(widget.quizId)).value;
    });

    return Scaffold(
      appBar: quizAsync.when(
        data: (quiz) {
          final classAsync = ref.watch(singleClassProvider(quiz.classId));
          return classAsync.when(
            data:
                (classData) => AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        shareService.shareQuiz(
                          quiz,
                          classData.title,
                          context,
                          students,
                          results,
                        );
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
                        } else if (value == 'editMxScore') {
                          quizAsync.whenData(
                            (value) => _showEditMaxScoreDialog(
                              context,
                              ref,
                              value.maxScore?.toString(),
                            ),
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: 'editMxScore',
                              child: ListTile(
                                leading: Icon(Icons.edit_outlined),
                                title: Text(localizations.editMaxScore),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                title: Text(
                                  localizations.delete,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ),
                            ),
                          ],
                    ),
                  ],
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classData.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        quiz.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
            error: (e, _) => null,
            loading: () => AppBar(title: Text(localizations.loading)),
          );
        },
        error: (e, _) => null,
        loading: () => AppBar(title: Text(localizations.loading)),
      ),

      /// -- Body
      body: Form(
        key: _formKey,
        child: quizAsync.when(
          data: (quiz) {
            final studentsAsync = ref.watch(
              studentsByClassProvider(quiz.classId),
            );
            final existingResultsAsync = ref.watch(
              resultsByQuizProvider(widget.quizId),
            );
            return NestedScrollView(
              headerSliverBuilder: (
                BuildContext context,
                bool innerBoxIsScrolled,
              ) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16,
                      ),
                      child: Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.overview,

                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 16),
                              DetailRow(
                                title: localizations.dateTitle,
                                value: formatter.formatFull(quiz.date),
                                icon: Icons.calendar_month_outlined,
                                action: IconButton(
                                  // Added action to edit date
                                  tooltip: localizations.editDateTooltip,
                                  // Needs localization
                                  onPressed:
                                      () => _showEditQuizDateTimeDialog(
                                        context,
                                        ref,
                                        widget.quizId,
                                        quiz.date,
                                      ),
                                  icon: Icon(
                                    Icons.edit_calendar_outlined,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                              if (quiz.description != null &&
                                  quiz.description!.isNotEmpty)
                                DetailRow(
                                  title: localizations.description,
                                  value: quiz.description!,
                                  icon: Icons.notes_outlined,
                                  action: IconButton(
                                    onPressed:
                                        () => _showEditDescriptionDialog(
                                          context,
                                          ref,
                                          widget.quizId,
                                          quiz.description,
                                        ),

                                    icon: Icon(
                                      Icons.edit,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                ),

                              if (quiz.description == null ||
                                  quiz.description!.isEmpty)
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton(
                                    onPressed:
                                        () => _showEditDescriptionDialog(
                                          context,
                                          ref,
                                          widget.quizId,
                                          quiz.description,
                                        ),
                                    child: Text(localizations.addDescription),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        height: 64, // Choose the actual height you need
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.scoreboard_outlined,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 22,
                              ),
                              SizedBox(width: 8),
                              Text(
                                quiz.maxScore != null
                                    ? localizations.scoresFrom(quiz.maxScore!)
                                    : localizations.scores,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              FilledButton(
                                onPressed: () {
                                  final studentsAsync = ref.read(
                                    studentsByClassProvider(quiz.classId),
                                  );
                                  studentsAsync.whenData((students) {
                                    if (_areControllersInitialized &&
                                        students.isNotEmpty) {
                                      _saveResults(quiz, students);
                                    }
                                  });
                                },
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                ),
                                child: Text(localizations.saveResults),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                            bottom: 4,
                          ),
                          child: studentsAsync.when(
                            data: (students) {
                              if (students.isEmpty) {
                                return _buildEmptyState(
                                  context,
                                  Icons.sentiment_dissatisfied_outlined,
                                  localizations.noStudentsInClassForQuiz,
                                  null,
                                );
                              }
                              return existingResultsAsync.when(
                                data: (existingResults) {
                                  _synchronizeScoreControllers(
                                    students,
                                    existingResults,
                                  );
                                  if (!_areControllersInitialized) {
                                    return const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(32.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return SafeArea(
                                    child: Card(
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(36),
                                      ),
                                      child: ListView.separated(
                                        padding: EdgeInsets.symmetric(vertical: 8),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: students.length,
                                        itemBuilder: (context, index) {
                                          final student = students[index];
                                          final controller =
                                              _scoreControllers[student.id];
                                          if (controller == null) {
                                            return const SizedBox.shrink(); // Should be initialized
                                          }

                                          return ListTile(
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                                            leading: GestureDetector(
                                              onTap: (){
                                                context.pushNamed(
                                                  Routes.studentDetail,
                                                  pathParameters: {'studentId': student.id.toString()},
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .secondaryContainer,
                                                child: Text(
                                                  student.name.isNotEmpty
                                                      ? student.name[0]
                                                          .toUpperCase()
                                                      : 'S',
                                                  style: TextStyle(
                                                    color:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              student.name,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.titleMedium,
                                            ),
                                            trailing: SizedBox(
                                              width: 85,
                                              // Slightly adjusted width
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: controller,
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                    ),
                                                decoration: InputDecoration(
                                                  hintText:
                                                      localizations
                                                          .scoreLabel,
                                                  // Using scoreLabel as hint
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16,
                                                        ),
                                                  ),
                                                  // Rounded border
                                                  isDense: true,
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 12,
                                                      ),
                                                ),
                                                textAlign: TextAlign.center,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return null;
                                                  }
                                                  final score =
                                                      double.tryParse(value);
                                                  if (score == null) {
                                                    return localizations
                                                        .invalidNumberShort;
                                                  }
                                                  if (score < 0) {
                                                    return localizations
                                                        .scorePositiveShort;
                                                  }
                                                  return null;
                                                },
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction, // Consider enabling after first save attempt or on field focus change
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (_, __) => Divider(
                                          color: Theme.of(context).colorScheme.surface,
                                          thickness: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                loading:
                                    () => const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(32.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                error:
                                    (e, _) => _buildEmptyState(
                                      context,
                                      Icons.error_outline_rounded,
                                      localizations.errorLoadingQuizResults,
                                      e.toString(),
                                    ),
                              );
                            },
                            loading:
                                () => const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(32.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            error:
                                (e, _) => _buildEmptyState(
                                  context,
                                  Icons.error_outline_rounded,
                                  localizations.errorLoadingStudents,
                                  e.toString(),
                                ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },

          loading:
              () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),
          error:
              (e, _) => _buildEmptyState(
                context,
                Icons.error_outline_rounded,
                localizations.errorLoadingQuizDetails,
                e.toString(),
              ),
        ),
      ),
    );
  }
}

extension _FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

// Helper class for the Edit Quiz DateTime Dialog content
class _EditQuizDateTimeDialogContent extends ConsumerStatefulWidget {
  final DateTime initialDateTime;
  final AppLocalizations localizations;

  const _EditQuizDateTimeDialogContent({
    required this.initialDateTime,
    required this.localizations,
  });

  @override
  ConsumerState<_EditQuizDateTimeDialogContent> createState() =>
      _EditQuizDateTimeDialogContentState();
}

class _EditQuizDateTimeDialogContentState
    extends ConsumerState<_EditQuizDateTimeDialogContent> {
  late DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = widget.initialDateTime;
  }

  Future<void> _selectDateTimeInDialog(BuildContext context) async {
    dynamic pickedDate;
    final calendarType = ref.watch(calendarTypeSettingProvider);
    if (calendarType == CalendarType.persian) {
      final jalali = await showPersianDatePicker(
        context: context,
        initialDate:
            _selectedDateTime != null
                ? Jalali.fromDateTime(_selectedDateTime!)
                : Jalali.now(),
        firstDate: Jalali(1404),
        lastDate: Jalali(1450),
        locale: Locale("fa", "IR"),
      );
      if (jalali == null) return;
      pickedDate = jalali.toGregorian().toDateTime();
    } else {
      pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDateTime ?? DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2100),
      );
    }

    if (pickedDate != null) {
      // ignore: use_build_context_synchronously
      if (!context.mounted) return;
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          _selectedDateTime ?? DateTime.now(),
        ),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = widget.localizations;
    final formatter = ref.watch(tMDateFormatterProvider);

    return AlertDialog(
      title: Text(localizations.editQuizDateTimeTitle), // Needs localization
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            localizations.selectNewDateTimePrompt,
            style: theme.textTheme.bodyMedium,
          ), // Re-use or new localization
          const SizedBox(height: 20),
          TextButton(
            style: TextButton.styleFrom(
              alignment:
                  localizations.localeName == 'fa'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: theme.colorScheme.outline),
              ),
              minimumSize: const Size(double.infinity, 0),
            ),
            onPressed: () => _selectDateTimeInDialog(context),
            child: Text(
              _selectedDateTime != null
                  ? formatter.formatFull(_selectedDateTime!)
                  : localizations.pickQuizDateTime, // Needs localization
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight:
                    _selectedDateTime == null
                        ? FontWeight.normal
                        : FontWeight.w500,
                color:
                    _selectedDateTime == null
                        ? theme.hintColor
                        : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(localizations.cancelButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text(localizations.saveButton),
          onPressed: () {
            if (_selectedDateTime != null) {
              Navigator.of(context).pop(_selectedDateTime);
            }
          },
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.child, required this.height});

  final Widget child;
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: .9),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return child != oldDelegate.child || height != oldDelegate.height;
  }
}

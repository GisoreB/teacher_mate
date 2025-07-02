import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/quizzes_providers.dart';
import 'package:teacher_mate/applications/state_management/sessions_providers.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';
import 'package:teacher_mate/infrastructure/data/session_status.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';
import 'package:teacher_mate/presentation/widgets/icon_input_row_widget.dart';

class AddQuizScreen extends ConsumerStatefulWidget {
  final int classId;

  const AddQuizScreen({super.key, required this.classId});

  @override
  ConsumerState<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends ConsumerState<AddQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _maxScoreController = TextEditingController();

  DateTime? _quizDateTime; // Renamed for clarity

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _maxScoreController.dispose();
    super.dispose();
  }

  // Renamed to _selectDateTime
  Future<void> _selectDateTime(BuildContext context) async {
    dynamic date;
    final calendarType = ref.watch(calendarTypeSettingProvider);
    if (calendarType == CalendarType.persian) {
      final jalali = await showPersianDatePicker(
        context: context,
        initialDate: Jalali.now(),
        firstDate: Jalali(1404),
        lastDate: Jalali(1450),
        locale: Locale("fa", "IR"),
      );
      if (jalali == null) return;
      date = jalali.toGregorian().toDateTime();
    } else {
      date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2025),
        lastDate: DateTime(2100),
      );
    }

    if (date == null) return; // User cancelled DatePicker

    // ignore: use_build_context_synchronously
    if (!context.mounted) return; // Check if context is still valid

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_quizDateTime ?? DateTime.now()),
    );

    if (time == null) return;

    setState(() {
      _quizDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submitForm() async {
    FocusScope.of(context).unfocus(); // Dismiss keyboard

    if (_formKey.currentState!.validate()) {
      if (_quizDateTime == null) {
        // Show an error if date/time is not picked
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              // Updated localization key
              AppLocalizations.of(context)!.pickQuizDateError,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      await ref
          .read(quizRepositoryProvider.notifier)
          .insert(
            QuizzesCompanion.insert(
              classId: widget.classId,
              title: _titleController.text,
              date: _quizDateTime!,
              maxScore: drift.Value(int.tryParse(_maxScoreController.text)),
              description: drift.Value(
                _descriptionController.text.isEmpty
                    ? null
                    : _descriptionController.text,
              ),
            ),
          );

      if (!mounted) return;
      context.pop(); // Go back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final screenContext = context;

    final sessionsAsync = ref.read(sessionsByClassProvider(widget.classId));
    final formatter = ref.watch(tMDateFormatterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.createNewQuiz),
        actions: [
          FilledButton(
            onPressed: _submitForm,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(localizations.save),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              IconInputRow(
                icon: Icons.title_rounded,
                child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: localizations.quizTitleLabel,
                    border: const OutlineInputBorder(),
                    hintText: localizations.enterQuizTitleHint,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.enterQuizTitleError;
                    }
                    return null;
                  },
                ),
              ),
              IconInputRow(
                icon: Icons.calendar_today_rounded,
                isPicker: true,
                child: TextButton(
                  style: TextButton.styleFrom(
                    alignment:
                        AppLocalizations.of(context)!.localeName == 'fa'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  onPressed:
                      () => showDialog<void>(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text(localizations.pickQuizDateTime),
                            contentPadding: EdgeInsets.all(16),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
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
                                    child: Text(
                                      localizations.selectFromCalendar,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(dialogContext);
                                      _selectDateTime(context);
                                    },
                                  ),
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: double.infinity,
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
                                    child: Text(
                                      localizations.selectFromSessionDates,
                                    ),
                                    onPressed: () {
                                      sessionsAsync.when(
                                        data: (allSessions) {
                                          final scheduledSessions = [
                                            for (var s in allSessions)
                                              if (s.status ==
                                                  SessionStatus.scheduled)
                                                s,
                                          ];

                                          if (scheduledSessions.isEmpty) {
                                            Navigator.pop(dialogContext);
                                            ScaffoldMessenger.of(
                                              screenContext,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  localizations
                                                      .noScheduledSessions,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                              ),
                                            );
                                            return;
                                          }
                                          showDialog<DateTime>(
                                            context: dialogContext,
                                            builder: (
                                              BuildContext
                                              sessionListDialogContext,
                                            ) {
                                              return AlertDialog(
                                                title: Text(
                                                  localizations.selectSession,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(16.0),
                                                content: SizedBox(
                                                  width: double.maxFinite,
                                                  child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        scheduledSessions
                                                            .length,
                                                    itemBuilder: (
                                                      BuildContext listContext,
                                                      int index,
                                                    ) {
                                                      final session =
                                                          scheduledSessions[index];
                                                      return ListTile(
                                                        title: Text(
                                                          localizations
                                                              .sessionNumber(
                                                                session.number,
                                                              ),
                                                        ),
                                                        subtitle: Text(
                                                          formatter.formatFull(
                                                            session.date,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          Navigator.pop(
                                                            sessionListDialogContext,
                                                            session.date,
                                                          ); // Pop session list, return date
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                        sessionListDialogContext,
                                                      );
                                                    },
                                                    child: Text(
                                                      localizations.cancel,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ).then((selectedDate) {
                                            if (!dialogContext.mounted) return;
                                            Navigator.pop(dialogContext);

                                            if (selectedDate != null) {
                                              setState(() {
                                                _quizDateTime = selectedDate;
                                              });
                                            }
                                          });
                                        },
                                        loading: () {
                                          Navigator.pop(dialogContext);
                                          ScaffoldMessenger.of(
                                            screenContext,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                localizations.loading,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ), // Consider localizing
                                          );
                                        },
                                        error: (err, stack) {
                                          Navigator.pop(dialogContext);
                                          ScaffoldMessenger.of(
                                            screenContext,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Error loading sessions: $err',
                                              ),
                                            ), // Consider localizing
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  child: Text(
                    _quizDateTime != null
                        ? formatter.formatFull(_quizDateTime!)
                        : localizations.pickQuizDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight:
                          _quizDateTime == null
                              ? FontWeight.normal
                              : FontWeight.w500,
                      color:
                          _quizDateTime == null
                              ? Theme.of(context).hintColor
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              IconInputRow(
                icon: Icons.bar_chart_outlined,
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _maxScoreController,
                  decoration: InputDecoration(
                    labelText: localizations.maxScoreLabel,
                    border: const OutlineInputBorder(),
                    hintText: localizations.enterMaxScoreHint,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              IconInputRow(
                icon: Icons.description_outlined,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: localizations.quizDescriptionLabel,
                    border: const OutlineInputBorder(),
                    hintText: localizations.enterQuizDescriptionHint,
                  ),
                  maxLines: 3,
                ),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  localizations.requiredFieldsNote,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

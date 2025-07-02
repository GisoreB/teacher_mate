import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/classes_providers.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/sessions_providers.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';
import 'package:teacher_mate/presentation/widgets/icon_input_row_widget.dart';

class AddClassScreen extends ConsumerStatefulWidget {
  const AddClassScreen({super.key});

  @override
  ConsumerState<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends ConsumerState<AddClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _sessionCountController = TextEditingController();
  final _syllabusController = TextEditingController();

  DateTime? _firstSession;
  final Set<int> _selectedWeekdays = {}; // 1=Mon, 7=Sun

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

    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (time == null) return;

    setState(() {
      _firstSession = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submitForm() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      if (_firstSession == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.pickFirstSessionDateError,
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
      if (_selectedWeekdays.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.selectSessionDaysError,
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

      final sessionCount = int.parse(_sessionCountController.text);

      final classId = await ref
          .read(classRepositoryProvider.notifier)
          .insertClass(
            ClassesCompanion.insert(
              title: _titleController.text,
              description: drift.Value(_descriptionController.text),
              duration: int.parse(_durationController.text),
              firstSession: _firstSession!,
              sessionCount: sessionCount,
              syllabus: drift.Value(_syllabusController.text),
            ),
          );

      final List<DateTime> sessionDates = [];
      DateTime current = _firstSession!;
      while (sessionDates.length < sessionCount) {
        if (_selectedWeekdays.contains(current.weekday)) {
          sessionDates.add(current);
        }
        current = current.add(const Duration(days: 1));
      }

      for (int i = 0; i < sessionDates.length; i++) {
        await ref
            .read(sessionRepositoryProvider.notifier)
            .insert(
              SessionsCompanion.insert(
                classId: classId,
                number: i + 1,
                date: sessionDates[i],
                homework: const drift.Value(null),
                note: const drift.Value(null),
              ),
            );
      }
      if (!mounted) return;
      context.pop();
      context.pushNamed(
        Routes.classDetail,
        pathParameters: {'classId': classId.toString()},
      );
    }
  }

  Widget _buildWeekdaySelector() {
    final weekdayNames = [
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.sunday,
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
    ];

    final weekdayNumbers = [
      6,
      7,
      1,
      2,
      3,
      4,
      5,
    ]; // Saturday=6, Sunday=7, ..., Friday=5

    return Wrap(
      spacing: 8,
      children: List.generate(7, (index) {
        final day = weekdayNumbers[index];
        final isSelected = _selectedWeekdays.contains(day);
        return FilterChip(
          label: Text(weekdayNames[index]),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedWeekdays.add(day);
              } else {
                _selectedWeekdays.remove(day);
              }
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formatter = ref.watch(tMDateFormatterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createClass),
        actions: [
          FilledButton(
            onPressed: _submitForm,
            child: Text(AppLocalizations.of(context)!.save),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconInputRow(
                  icon: Icons.title,
                  child: TextFormField(
                    autofocus: true,
                    focusNode: FocusNode(),
                    textInputAction: TextInputAction.next,
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.classTitleLabel,
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppLocalizations.of(
                                  context,
                                )!.enterClassTitleError
                                : null,
                  ),
                ),

                IconInputRow(
                  icon: Icons.timer,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _durationController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.durationLabel,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppLocalizations.of(
                                  context,
                                )!.enterDurationError
                                : null,
                  ),
                ),
                IconInputRow(
                  icon: Icons.format_list_numbered,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _sessionCountController,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.numberOfSessionsLabel,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? AppLocalizations.of(
                                  context,
                                )!.enterSessionCountError
                                : null,
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
                    onPressed: () => _selectDateTime(context),
                    // Updated method call
                    child: Text(
                      _firstSession != null
                          ? formatter.formatFull(_firstSession!)
                          : AppLocalizations.of(context)!.pickFirstSessionDate,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight:
                            _firstSession == null
                                ? FontWeight.normal
                                : FontWeight.w500,
                        color:
                            _firstSession == null
                                ? Theme.of(context).hintColor
                                : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                IconInputRow(
                  icon: Icons.view_week,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.selectWeekdaysLabel),
                      _buildWeekdaySelector(),
                    ],
                  ),
                ),
                IconInputRow(
                  icon: Icons.description,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.descriptionLabel,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconInputRow(
                  icon: Icons.book,
                  child: TextFormField(
                    controller: _syllabusController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.syllabusLabel,
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    AppLocalizations.of(context)!.requiredFieldsNote,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

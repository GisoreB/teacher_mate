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
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';
import 'package:teacher_mate/presentation/widgets/icon_input_row_widget.dart';

class AddSessionScreen extends ConsumerStatefulWidget {
  final int classId;

  const AddSessionScreen({super.key, required this.classId});

  @override
  ConsumerState<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends ConsumerState<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _homeworkController = TextEditingController();
  final _noteController = TextEditingController();

  DateTime? _sessionDate;
  int _sessionNumber = 1;

  @override
  void initState() {
    super.initState();
    _loadLastSessionNumber();
  }

  Future<void> _loadLastSessionNumber() async {
    final lastSessionNumber = await ref
        .read(sessionRepositoryProvider.notifier)
        .getLastSessionNumber(widget.classId);
    setState(() {
      _sessionNumber = (lastSessionNumber ?? 0) + 1;
    });
  }

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
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _sessionDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_sessionDate == null) {
        // Show an error if date/time is not picked
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.pickSessionDateError,
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
          .read(sessionRepositoryProvider.notifier)
          .insert(
            SessionsCompanion.insert(
              classId: widget.classId,
              number: _sessionNumber,
              date: _sessionDate!,
              homework: drift.Value(_homeworkController.text),
              note: drift.Value(_noteController.text),
            ),
          );

      await ref
          .read(classRepositoryProvider.notifier)
          .updateSessionCount(widget.classId, 1);

      if (!mounted) return;
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = ref.watch(tMDateFormatterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.scheduleSession(_sessionNumber),
        ),
        actions: [
          FilledButton(
            onPressed: _submitForm,
            child: Text(AppLocalizations.of(context)!.save),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    _sessionDate != null
                        // Updated DateFormat to include time
                        ? formatter.formatFull(_sessionDate!)
                        // Updated localization key
                        : AppLocalizations.of(context)!.pickSessionDate,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight:
                          _sessionDate == null
                              ? FontWeight.normal
                              : FontWeight.w500,
                      color:
                          _sessionDate == null
                              ? Theme.of(context).hintColor
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              IconInputRow(
                icon: Icons.note,
                child: TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.noteLabel,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  AppLocalizations.of(context)!.requiredFieldsNote,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
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

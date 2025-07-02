import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/classes_providers.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/sessions_providers.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/applications/state_management/student_activities_providers.dart';
import 'package:teacher_mate/applications/state_management/students_providers.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';
import 'package:teacher_mate/infrastructure/data/session_status.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/share_service.dart';
import 'package:teacher_mate/presentation/widgets/detail_row_widget.dart';
import 'package:teacher_mate/presentation/widgets/session_students_card_widget.dart';

class SessionDetailScreen extends ConsumerWidget {
  final int sessionId;

  const SessionDetailScreen({super.key, required this.sessionId});

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String message,
    String? subMessage,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      child: Column(
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

  Future<void> _showEditNoteDialog(
    BuildContext context,
    WidgetRef ref,
    int sessionId,
    String? currentNote, // Pass the current note to pre-fill the TextField
  ) async {
    final noteController = TextEditingController(text: currentNote);
    final formKey = GlobalKey<FormState>(); // For optional validation

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.editNote),
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
                    hintText: AppLocalizations.of(context)!.enterNoteHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.save),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newNote = noteController.text.trim();
                  ref
                      .read(sessionRepositoryProvider.notifier)
                      .updateNote(sessionId, newNote);
                  context.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditHomeworkDialog(
    BuildContext context,
    WidgetRef ref,
    int sessionId,
    String? currentHomework,
  ) async {
    final homeworkController = TextEditingController(text: currentHomework);
    final formKey = GlobalKey<FormState>();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.editHomework),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: homeworkController,
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enterHomeworkHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                context.pop(); // Dismiss dialog
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.save),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newHomework = homeworkController.text.trim();
                  ref
                      .read(sessionRepositoryProvider.notifier)
                      .updateHomework(sessionId, newHomework);
                  context.pop(); // Dismiss dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditSessionDateTimeDialog(
    BuildContext context,
    WidgetRef ref,
    int currentSessionId, // Renamed for clarity
    DateTime initialDateTime,
  ) async {
    final localizations =
        AppLocalizations.of(context)!; // Get localizations once
    final newDateTime = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext dialogContext) {
        // Pass localizations to the dialog content
        return _EditSessionDateTimeDialogContent(
          initialDateTime: initialDateTime,
          localizations: localizations,
        );
      },
    );

    if (newDateTime != null && context.mounted) {
      // User saved a new date and time
      try {
        await ref
            .read(sessionRepositoryProvider.notifier)
            .updateDate(currentSessionId, newDateTime);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(localizations.sessionDateTimeUpdatedSuccess),
            behavior: SnackBarBehavior.floating,
          ), // Add localization
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${localizations.errorUpdatingSessionDateTime}: $e'),
            behavior: SnackBarBehavior.floating,
          ), // Add localization
        );
      }
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    int classId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.confirmDeleteTitle),
            content: Text(
              AppLocalizations.of(context)!.confirmDeleteSessionMessage,
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
      ref.read(sessionRepositoryProvider.notifier).delete(sessionId);
      ref
          .read(classRepositoryProvider.notifier)
          .updateSessionCount(classId, -1);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionAsync = ref.watch(singleSessionProvider(sessionId));
    final formatter = ref.watch(tMDateFormatterProvider);
    final shareService = ShareService(formatter);

    return Scaffold(
      appBar: sessionAsync.when(
        data: (session) {
          final classAsync = ref.watch(singleClassProvider(session.classId));
          return classAsync.when(
            data:
                (classData) => AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {
                        shareService.shareSession(
                          session,
                          classData.title,
                          context,
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
                          _showDeleteConfirmation(context, ref, classData.id);
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
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        classData.title,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.sessionNumber(session.number),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
            error: (e, _) => null,
            loading:
                () =>
                    AppBar(title: Text(AppLocalizations.of(context)!.loading)),
          );
        },
        error: (e, _) => null,
        loading:
            () => AppBar(title: Text(AppLocalizations.of(context)!.loading)),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: sessionAsync.when(
                  data: (session) {
                    Color color;
                    switch (session.status) {
                      case SessionStatus.completed:
                        color = Colors.green.shade700;
                        break;
                      case SessionStatus.cancelled:
                        color = Colors.red.shade700;
                        break;
                      case SessionStatus.substitute:
                        color = Colors.orange.shade700;
                        break;
                      case SessionStatus.scheduled:
                        color = Theme.of(context).colorScheme.secondary;
                        break;
                    }
                    return Card(
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
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.overview,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Spacer(),
                                PopupMenuButton<SessionStatus>(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  onSelected: (SessionStatus newStatus) {
                                    ref
                                        .read(
                                          sessionRepositoryProvider.notifier,
                                        )
                                        .updateStatus(session.id, newStatus);
                                  },
                                  itemBuilder:
                                      (BuildContext context) =>
                                          <PopupMenuEntry<SessionStatus>>[
                                            PopupMenuItem<SessionStatus>(
                                              value: SessionStatus.scheduled,
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.schedule_outlined,
                                                ),
                                                title: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.scheduled,
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem<SessionStatus>(
                                              value: SessionStatus.completed,
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.check_circle_outline,
                                                ),
                                                title: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.completed,
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem<SessionStatus>(
                                              value: SessionStatus.cancelled,
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.cancel_outlined,
                                                ),
                                                title: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.cancelled,
                                                ),
                                              ),
                                            ),
                                            PopupMenuItem<SessionStatus>(
                                              value: SessionStatus.substitute,
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.people_alt_outlined,
                                                ),
                                                title: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.substitute,
                                                ),
                                              ),
                                            ),
                                          ],
                                  child: Chip(
                                    side: BorderSide(color: color),
                                    backgroundColor: color.withValues(
                                      alpha: 0.15,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),

                                    avatar: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: color,
                                    ),
                                    label: Text(
                                      style: TextStyle(color: color),
                                      AppLocalizations.of(
                                        context,
                                      )!.sessionStatus(session.status.name),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            DetailRow(
                              title: AppLocalizations.of(context)!.dateTitle,
                              value: formatter.formatFull(session.date),
                              // localizedDateTimeFormatter(
                              //   session.date,
                              //   AppLocalizations.of(context)!,
                              // ),
                              icon: Icons.event,
                              action: IconButton(
                                onPressed: () {
                                  _showEditSessionDateTimeDialog(
                                    context,
                                    ref,
                                    session.id,
                                    session.date,
                                  );
                                },
                                icon: Icon(
                                  Icons.edit_calendar_outlined,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            if (session.note != null &&
                                session.note!.isNotEmpty)
                              DetailRow(
                                title: AppLocalizations.of(context)!.note,
                                value: session.note!,
                                icon: Icons.subject,
                                action: IconButton(
                                  onPressed: () {
                                    _showEditNoteDialog(
                                      context,
                                      ref,
                                      session.id,
                                      session.note,
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            if (session.homework != null &&
                                session.homework!.isNotEmpty)
                              DetailRow(
                                title: AppLocalizations.of(context)!.homework,
                                value: session.homework!,
                                icon: Icons.assignment_outlined,
                                action: IconButton(
                                  onPressed: () {
                                    _showEditHomeworkDialog(
                                      context,
                                      ref,
                                      session.id,
                                      session.homework,
                                    );
                                  },

                                  icon: Icon(
                                    Icons.edit,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                            Row(
                              children: [
                                if (session.note == null ||
                                    session.note!.isEmpty)
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        _showEditNoteDialog(
                                          context,
                                          ref,
                                          session.id,
                                          session.note,
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.addNote,
                                      ),
                                    ),
                                  ),

                                if ((session.note == null ||
                                        session.note!.isEmpty) &&
                                    (session.homework == null ||
                                        session.homework!.isEmpty))
                                  SizedBox(width: 8),
                                if (session.homework == null ||
                                    session.homework!.isEmpty)
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        _showEditHomeworkDialog(
                                          context,
                                          ref,
                                          session.id,
                                          session.homework,
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.addHomework,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (e, _) => _buildEmptyState(
                        context,
                        Icons.error_outline_rounded,
                        AppLocalizations.of(context)!.errorLoadingSession,
                        e.toString(),
                      ),
                ),
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  height: 56, // Choose the actual height you need
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.groups_2_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 22,
                        ),
                        const SizedBox(width: 8),

                        Text(
                          AppLocalizations.of(context)!.students,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.attendance,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(' | '),
                        Text(
                          AppLocalizations.of(context)!.homework,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(' | '),
                        Text(
                          AppLocalizations.of(context)!.classActivity,
                          style: Theme.of(context).textTheme.labelMedium,
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
                      bottom: 24,
                    ),
                    child: sessionAsync.when(
                      data: (session) {
                        final studentsAsync = ref.watch(
                          studentsByClassProvider(session.classId),
                        );
                        return studentsAsync.when(
                          data: (students) {
                            final activitiesAsync = ref.watch(
                              activitiesForSessionProvider(sessionId),
                            );
                            if (students.isEmpty) {
                              return _buildEmptyState(
                                context,
                                Icons.sentiment_dissatisfied_outlined,
                                AppLocalizations.of(context)!.noStudentsYet,
                                AppLocalizations.of(
                                  context,
                                )!.goToClassToAddStudents,
                              );
                            }
                            return Column(
                              children: [
                                activitiesAsync.when(
                                  data: (activities) {
                                    return SessionStudentsCard(
                                      students,
                                      sessionId,
                                      activities,
                                    );
                                  },
                                  error: (e, _) => Text(e.toString()),
                                  loading:
                                      () => const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(32.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                ),
                              ],
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
                                AppLocalizations.of(
                                  context,
                                )!.errorLoadingStudents,
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
                            AppLocalizations.of(context)!.errorLoadingStudents,
                            e.toString(),
                          ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Helper class for the Edit DateTime Dialog content
class _EditSessionDateTimeDialogContent extends ConsumerStatefulWidget {
  final DateTime initialDateTime;
  final AppLocalizations localizations; // Pass localizations

  const _EditSessionDateTimeDialogContent({
    required this.initialDateTime,
    required this.localizations,
  });

  @override
  ConsumerState<_EditSessionDateTimeDialogContent> createState() =>
      _EditSessionDateTimeDialogContentState();
}

class _EditSessionDateTimeDialogContentState
    extends ConsumerState<_EditSessionDateTimeDialogContent> {
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
    // Use passed localizations
    final localizations = widget.localizations;
    final formatter = ref.watch(tMDateFormatterProvider);

    return AlertDialog(
      title: Text(localizations.editSessionDateTimeTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            localizations.selectNewDateTimePrompt,
            style: theme.textTheme.bodyMedium,
          ),
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
                  : localizations.pickSessionDate,
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

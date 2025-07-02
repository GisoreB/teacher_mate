import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_mate/applications/state_management/classes_providers.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/quizzes_providers.dart';
import 'package:teacher_mate/applications/state_management/sessions_providers.dart';
import 'package:teacher_mate/applications/state_management/students_providers.dart';
import 'package:teacher_mate/infrastructure/data/session_status.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';
import 'package:teacher_mate/presentation/helpers/share_service.dart';
import 'package:teacher_mate/presentation/widgets/detail_row_widget.dart';

enum SessionFilterOption { all, scheduled, completed, cancelled, substitute }

class ClassDetailScreen extends ConsumerStatefulWidget {
  final int classId;

  const ClassDetailScreen({super.key, required this.classId});

  @override
  ConsumerState<ClassDetailScreen> createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends ConsumerState<ClassDetailScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  SessionFilterOption _selectedFilterOption = SessionFilterOption.all;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Chip(
          avatar: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
          label: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    IconData icon,
    String message,
    String? subMessage,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
      alignment: Alignment.center,
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

  void _showActivationToggleDialog(bool isActive) async {
    final localizations = AppLocalizations.of(context)!;
    await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            isActive ? localizations.deactivate : localizations.activate,
          ),
          content: Text(
            isActive
                ? localizations.deactivateQuestion
                : localizations.activateQuestion,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor:
                    isActive ? Theme.of(context).colorScheme.error : null,
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ref
                    .read(classRepositoryProvider.notifier)
                    .updateIsActive(widget.classId, !isActive);
              },
              child: Text(
                isActive ? localizations.deactivate : localizations.activate,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddSyllabusDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final localizations = AppLocalizations.of(context)!;
    final currentClass = await ref.read(
      singleClassProvider(widget.classId).future,
    );
    final syllabusController = TextEditingController(
      text: currentClass.syllabus,
    );
    final formKey = GlobalKey<FormState>();

    if (!context.mounted) return;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizations.addSyllabus),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFormField(
                  controller: syllabusController,
                  autofocus: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: localizations.enterSyllabusHint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(localizations.save),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  final newSyllabus = syllabusController.text.trim();
                  ref
                      .read(classRepositoryProvider.notifier)
                      .updateSyllabus(widget.classId, newSyllabus);
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSessionStatusChip(BuildContext context, SessionStatus status) {
    IconData iconData;
    Color color;
    final localizations = AppLocalizations.of(context)!;

    switch (status) {
      case SessionStatus.completed:
        iconData = Icons.check_circle_outline_rounded;
        color = Colors.green.shade700;
        break;
      case SessionStatus.cancelled:
        iconData = Icons.cancel_outlined;
        color = Colors.red.shade700;
        break;
      case SessionStatus.substitute:
        iconData = Icons.people_alt_outlined;
        color = Colors.orange.shade700;
        break;
      case SessionStatus.scheduled:
        iconData = Icons.schedule_outlined;
        color = Theme.of(context).colorScheme.secondary;
        break;
    }

    return Chip(
      avatar: Icon(iconData, size: 16, color: color),
      label: Text(localizations.sessionStatus(status.name)),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
      backgroundColor: color.withValues(alpha: 0.15),
      padding: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }

  void _showDeleteConfirmation(BuildContext context) async {
    final localizations = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(localizations.confirmDeleteTitle),
            content: Text(localizations.confirmDeleteClassMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(localizations.cancel),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(localizations.delete),
              ),
            ],
          ),
    );
    if (confirmed == true) {
      if (context.mounted) {
        context.pop();
      }
      ref
          .read(classRepositoryProvider.notifier)
          .deleteClassWithRelations(widget.classId);
    }
  }

  Widget _buildStudentsTabContent(
    BuildContext context,
    WidgetRef ref,
    int classId,
  ) {
    final studentsAsync = ref.watch(studentsByClassProvider(classId));
    final localizations = AppLocalizations.of(context)!;

    return studentsAsync.when(
      data: (students) {
        if (students.isEmpty) {
          return _buildEmptyState(
            context,
            Icons.sentiment_dissatisfied_outlined,
            localizations.noStudentsYet,
            localizations.tapToEnrollFirstStudent,
          );
        }
        return Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            // Remains true
            physics: const NeverScrollableScrollPhysics(),
            // Remains NeverScrollable
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: Text(
                    student.name.isNotEmpty
                        ? student.name[0].toUpperCase()
                        : localizations.studentShort,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  student.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).hintColor,
                ),
                onTap: () {
                  context.pushNamed(
                    Routes.studentDetail,
                    pathParameters: {'studentId': student.id.toString()},
                  );
                },
              );
            },
            separatorBuilder:
                (_, __) => Divider(
                  color: Theme.of(context).colorScheme.surface,
                  thickness: 2,
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
            localizations.errorLoadingStudents,
            e.toString(),
          ),
    );
  }

  Widget _buildSessionsTabContent(
    BuildContext context,
    WidgetRef ref,
    int classId,
  ) {
    final sessionsAsync = ref.watch(sessionsByClassProvider(classId));
    final localizations = AppLocalizations.of(context)!;
    final formatter = ref.watch(tMDateFormatterProvider);

    return sessionsAsync.when(
      data: (sessions) {
        if (sessions.isEmpty) {
          return _buildEmptyState(
            context,
            Icons.event_busy_outlined,
            localizations.noSessionsScheduled,
            localizations.tapToScheduleFirstSession,
          );
        }
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredSessions =
                sessions.where((session) {
                  switch (_selectedFilterOption) {
                    case SessionFilterOption.all:
                      return true;
                    case SessionFilterOption.scheduled:
                      return session.status == SessionStatus.scheduled;
                    case SessionFilterOption.completed:
                      return session.status == SessionStatus.completed;
                    case SessionFilterOption.cancelled:
                      return session.status == SessionStatus.cancelled;
                    case SessionFilterOption.substitute:
                      return session.status == SessionStatus.substitute;
                  }
                }).toList();

            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // This makes it horizontal
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        ...SessionFilterOption.values.map((status) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: FilterChip(
                              showCheckmark: false,
                              visualDensity: VisualDensity.compact,
                              label: Text(
                                AppLocalizations.of(
                                  context,
                                )!.sessionStatus(status.name),
                              ),
                              selected: _selectedFilterOption == status,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilterOption = status;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                if (filteredSessions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.filter_alt_off,
                          size: 48,
                          color: Theme.of(context).hintColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          localizations.noSessionsFoundForFilter,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                if (filteredSessions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16,
                      bottom: 120,
                    ),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredSessions.length,
                        itemBuilder: (context, index) {
                          final session = filteredSessions[index];
                          return ListTile(
                            leading: Icon(
                              Icons.class_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 28,
                            ),
                            title: Row(
                              children: [
                                Text(
                                  localizations.sessionNumber(session.number),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                _buildSessionStatusChip(
                                  context,
                                  session.status,
                                ),
                              ],
                            ),
                            subtitle: Text(formatter.formatFull(session.date)),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Theme.of(context).hintColor,
                            ),
                            onTap: () {
                              context.pushNamed(
                                Routes.sessionDetail,
                                pathParameters: {
                                  'sessionId': session.id.toString(),
                                },
                              );
                            },
                          );
                        },
                        separatorBuilder:
                            (_, __) => Divider(
                              color: Theme.of(context).colorScheme.surface,
                              thickness: 2,
                            ),
                      ),
                    ),
                  ),
              ],
            );
          },
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
            localizations.errorLoadingSessions,
            e.toString(),
          ),
    );
  }

  Widget _buildQuizzesTabContent(
    BuildContext context,
    WidgetRef ref,
    int classId,
  ) {
    final quizzesAsync = ref.watch(quizzesByClassProvider(classId));
    final localizations = AppLocalizations.of(context)!;
    final formatter = ref.watch(tMDateFormatterProvider);

    return quizzesAsync.when(
      data: (quizzes) {
        if (quizzes.isEmpty) {
          return _buildEmptyState(
            context,
            Icons.quiz_rounded,
            localizations.noQuizzesYet,
            localizations.tapToAddFirstQuiz,
          );
        }
        return Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              String showDate = formatter.formatFull(quiz.date);
              return ListTile(
                leading: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  quiz.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(showDate),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Theme.of(context).hintColor,
                ),
                onTap: () {
                  context.pushNamed(
                    Routes.quizDetail,
                    pathParameters: {'quizId': quiz.id.toString()},
                  );
                },
              );
            },
            separatorBuilder:
                (_, __) => Divider(
                  color: Theme.of(context).colorScheme.surface,
                  thickness: 2,
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
            localizations.errorLoadingQuizzes,
            e.toString(),
          ),
    );
  }

  // Helper to make each tab's content scrollable, with appropriate padding
  Widget _buildScrollableTabContent(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(child: child),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final classAsync = ref.watch(singleClassProvider(widget.classId));
    final countAsync = ref.watch(
      scheduledSessionsCountProvider(widget.classId),
    );
    final localizations = AppLocalizations.of(context)!;
    final formatter = ref.watch(tMDateFormatterProvider);
    final shareService = ShareService(formatter);
    return Scaffold(
      appBar: classAsync.when(
        data:
            (classData) => AppBar(
              title: Text(classData.title),
              actions: [
                IconButton(
                  onPressed: () {
                    shareService.shareClass(classData, context);
                  },
                  icon: const Icon(Icons.share),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      context.pushNamed(
                        Routes.editClass,
                        pathParameters: {'classId': widget.classId.toString()},
                      );
                    } else if (value == 'delete') {
                      _showDeleteConfirmation(context);
                    } else if (value == 'switchActivation') {
                      _showActivationToggleDialog(classData.isActive);
                    }
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: const Icon(Icons.edit_outlined),
                            title: Text(localizations.edit),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'switchActivation',
                          child: ListTile(
                            leading: Icon(
                              classData.isActive
                                  ? Icons.cancel_outlined
                                  : Icons.check_circle_outline,
                              color:
                                  classData.isActive
                                      ? Theme.of(context).colorScheme.error
                                      : null,
                            ),
                            title: Text(
                              classData.isActive
                                  ? localizations.deactivate
                                  : localizations.activate,
                              style: TextStyle(
                                color:
                                    classData.isActive
                                        ? Theme.of(context).colorScheme.error
                                        : null,
                              ),
                            ),
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
            ),
        loading: () => AppBar(title: Text(localizations.loading)),
        error: (e, _) => AppBar(title: Text(localizations.error(e))),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            showDragHandle: true,
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.add_box_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 48,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.maxFinite,
                            height: 60,
                            child: FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                              ),
                              child: Text(
                                localizations.enrollStudent,
                                style: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                context.pop();
                                context.pushNamed(
                                  Routes.addStudent,
                                  pathParameters: {
                                    'classId': widget.classId.toString(),
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.maxFinite,
                            height: 60,
                            child: FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                              ),
                              child: Text(
                                localizations.scheduleSessionBtn,
                                style: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                context.pop();
                                context.pushNamed(
                                  Routes.addSession,
                                  pathParameters: {
                                    'classId': widget.classId.toString(),
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.maxFinite,
                            height: 60,
                            child: FilledButton.tonal(
                              style: FilledButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(8),
                                    bottom: Radius.circular(16),
                                  ),
                                ),
                              ),
                              child: Text(
                                localizations.createQuiz,
                                style: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                context.pop();
                                context.pushNamed(
                                  Routes.addQuiz,
                                  pathParameters: {
                                    'classId': widget.classId.toString(),
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                // Added vertical padding for spacing
                child: classAsync.when(
                  data: (classData) {
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
                                  localizations.overview,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Chip(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  avatar: Icon(
                                    classData.isActive
                                        ? Icons.check_circle_outline_rounded
                                        : Icons.highlight_off_rounded,
                                    size: 18,
                                    color:
                                        classData.isActive
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                            : Theme.of(
                                              context,
                                            ).colorScheme.error,
                                  ),
                                  label: Text(
                                    classData.isActive
                                        ? localizations.active
                                        : localizations.inactive,
                                  ),
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        classData.isActive
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.primary
                                            : Theme.of(
                                              context,
                                            ).colorScheme.error,
                                  ),
                                  backgroundColor:
                                      classData.isActive
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer
                                          : Theme.of(
                                            context,
                                          ).colorScheme.errorContainer,
                                  side: BorderSide.none,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildInfoChip(
                                  context,
                                  Icons.hourglass_bottom,
                                  localizations.duration(classData.duration),
                                  localizations.durationPerSession,
                                ),
                                _buildInfoChip(
                                  context,
                                  Icons.format_list_numbered_rounded,
                                  '${classData.sessionCount}',
                                  localizations.totalSessions,
                                ),
                                countAsync.when(
                                  data:
                                      (count) => _buildInfoChip(
                                        context,
                                        Icons.pending_actions,
                                        '$count',
                                        localizations.sessionsLeft,
                                      ),
                                  loading:
                                      () => const SizedBox(
                                        width: 60,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ),
                                  error: (e, _) {
                                    return Text(e.toString());
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            DetailRow(
                              title: localizations.startsOn,
                              value: formatter.formatFull(
                                classData.firstSession,
                              ),
                              icon: Icons.flag_outlined,
                            ),
                            if (classData.description != null &&
                                classData.description!.isNotEmpty)
                              DetailRow(
                                title: localizations.description,
                                value: classData.description!,
                                icon: Icons.info_outline,
                              ),
                            if (classData.syllabus != null &&
                                classData.syllabus!.isNotEmpty)
                              ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                iconColor:
                                    Theme.of(context).colorScheme.primary,
                                collapsedIconColor:
                                    Theme.of(context).colorScheme.secondary,
                                title: Text(
                                  localizations.syllabusOutline,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                childrenPadding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                children: [
                                  Text(
                                    classData.syllabus!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            if (classData.syllabus == null ||
                                classData.syllabus!.isEmpty)
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    _showAddSyllabusDialog(context, ref);
                                  },
                                  child: Text(localizations.addSyllabus),
                                ),
                              ),
                          ],
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
                        localizations.errorLoadingClass,
                        e.toString(),
                      ),
                ),
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: localizations.students),
                      Tab(text: localizations.sessions),
                      Tab(text: localizations.quizzes),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildScrollableTabContent(
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  top: 16,
                  bottom: 120,
                ),
                child: _buildStudentsTabContent(context, ref, widget.classId),
              ),
            ),
            _buildScrollableTabContent(
              _buildSessionsTabContent(context, ref, widget.classId),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16,
                top: 16,
                bottom: 120,
              ),
              child: _buildScrollableTabContent(
                _buildQuizzesTabContent(context, ref, widget.classId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Delegate for SliverPersistentHeader to make TabBar sticky
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return _tabBar != oldDelegate._tabBar; // Rebuild if TabBar changes
  }
}

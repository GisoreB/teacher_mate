import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_mate/applications/state_management/student_activities_providers.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';

class SessionStudentsCard extends ConsumerWidget {
  final List<Student> students;
  final int sessionId;
  final List<StudentActivity> activities;

  const SessionStudentsCard(
    this.students,
    this.sessionId,
    this.activities, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          final activity =
              activities.where((a) => a.studentId == student.id).firstOrNull;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    context.pushNamed(
                      Routes.studentDetail,
                      pathParameters: {'studentId': student.id.toString()},
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    child: Text(
                      student.name.isNotEmpty
                          ? student.name[0].toUpperCase()
                          : AppLocalizations.of(context)!.studentShort,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          student.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Checkbox(
                        value: activity?.attendance ?? false,
                        onChanged: (value) async {
                          await ref
                              .read(studentActivityRepositoryProvider.notifier)
                              .setAttendance(student.id, sessionId, value!);
                          if (!value) {
                            await ref
                                .read(
                                  studentActivityRepositoryProvider.notifier,
                                )
                                .setClassActivity(student.id, sessionId, value);
                          }
                        },
                      ),
                      Checkbox(
                        value: activity?.homework ?? false,
                        onChanged: (value) async {
                          await ref
                              .read(studentActivityRepositoryProvider.notifier)
                              .setHomework(student.id, sessionId, value!);
                        },
                      ),
                      Checkbox(
                        value: activity?.classActivity ?? false,
                        onChanged: (value) async {
                          await ref
                              .read(studentActivityRepositoryProvider.notifier)
                              .setClassActivity(student.id, sessionId, value!);
                          if (value) {
                            await ref
                                .read(
                                  studentActivityRepositoryProvider.notifier,
                                )
                                .setAttendance(student.id, sessionId, value);
                          }
                        },
                      ),
                    ],
                  ),
                ), // Your compact trailing element
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => Divider(
          color: Theme.of(context).colorScheme.surface,
          thickness: 2,
        ),
      ),
    );
  }
}

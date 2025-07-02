import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/applications/state_management/sessions_providers.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/infrastructure/router/router_consts.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';

class ClassCard extends ConsumerWidget {
  final Class classData;

  const ClassCard({super.key, required this.classData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countAsync = ref.watch(scheduledSessionsCountProvider(classData.id));
    final theme = Theme.of(context);
    final formatter = ref.watch(tMDateFormatterProvider);
    final dateFormatted = formatter.formatCompact(classData.firstSession);

    return ListTile(
      onTap: () {
        context.pushNamed(
          Routes.classDetail,
          pathParameters: {'classId': classData.id.toString()},
        );
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      // Adjusted vertical padding slightly for better balance with leading icon
      leading: Container(
        padding: const EdgeInsets.all(16), // Padding inside the container
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
          // Background color for the "boxy" look
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.school_outlined, // You can choose any icon you like
          color: theme.colorScheme.primary,
          size: 26, // Adjust icon size as needed
        ),
      ),
      title: Text(classData.title, style: theme.textTheme.titleMedium),
      subtitle: countAsync.when(
        data:
            (count) => Text(
              AppLocalizations.of(
                context,
              )!.sessionSummary(dateFormatted, classData.sessionCount, count),
              style:
                  theme
                      .textTheme
                      .bodySmall, // Ensure subtitle style is appropriate
            ),
        loading:
            () => const SizedBox(
              // Use SizedBox for a more controlled loading indicator size
              height: 16, // Match roughly the text line height
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2.0),
            ),
        error: (e, _) {
          return Text(
            e.toString(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          );
        },
      ),
      trailing: Icon(
        Icons.navigate_next,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}

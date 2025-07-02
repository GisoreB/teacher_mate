import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/date_formatter_provider.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';

class UpcomingCard extends ConsumerWidget {
  final String title;
  final String classTitle;
  final DateTime date;
  final IconData icon;
  final VoidCallback onTap;

  const UpcomingCard({
    super.key,
    required this.title,
    required this.classTitle,
    required this.date,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = ref.watch(tMDateFormatterProvider);
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    String formattedDateString;
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);
    final tomorrowDate = todayDate.add(const Duration(days: 1));
    DateTime eventDateOnly = DateTime(date.year, date.month, date.day);
    if (eventDateOnly == todayDate) {
      formattedDateString =
          "${localizations.today} ${DateFormat.jm(localizations.localeName).format(date)}"; // "Today 10:30 AM"
    } else if (eventDateOnly == tomorrowDate) {
      formattedDateString =
          "${localizations.tomorrow} ${DateFormat.jm(localizations.localeName).format(date)}"; // "Tomorrow 10:30 AM" - Needs localization
    } else {
      formattedDateString = formatter.formatShort(date);
    }

    return SizedBox(
      width: 280,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        margin: EdgeInsets.zero,
        elevation: 0,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          leading: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 26),
          ),
          title: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                classTitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                formattedDateString,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: const Icon(Icons.navigate_next),
          onTap: onTap,
        ),
      ),
    );
  }
}

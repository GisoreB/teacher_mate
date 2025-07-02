import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/infrastructure/router/router.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/l10n/l10n.dart';

class TeacherMateApp extends ConsumerWidget {
  const TeacherMateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Locale locale = ref.watch(localeSettingProvider);
    Color color = ref.watch(themeColorSettingProvider);
    ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: color);
    ColorScheme darkColorScheme = ColorScheme.fromSeed(
      seedColor: color,
      brightness: Brightness.dark,
    );
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Teacher Mate',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        cardTheme: CardThemeData(color: colorScheme.surfaceContainer),
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: ref.watch(themeModeSettingProvider),
      locale: locale != L10n.system ? locale : null,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        PersianMaterialLocalizations.delegate,
        ...AppLocalizations.localizationsDelegates,
      ],
    );
  }
}

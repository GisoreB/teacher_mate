// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/shared_prefs_provider.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';
import 'package:teacher_mate/l10n/l10n.dart';

part 'settings_provider.g.dart';

@riverpod
class ThemeModeSetting extends _$ThemeModeSetting {
  dynamic _prefs;

  @override
  ThemeMode build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final themeMode = _prefs.getInt('themeMode');
    return switch (themeMode) {
      1 => ThemeMode.light,
      2 => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  void changeTheme(ThemeMode themeMode) {
    state = themeMode;
    switch (themeMode) {
      case ThemeMode.light:
        _prefs.setInt('themeMode', 1);
      case ThemeMode.dark:
        _prefs.setInt('themeMode', 2);
      default:
        _prefs.remove('themeMode');
    }
  }
}

@riverpod
class LocaleSetting extends _$LocaleSetting {
  dynamic _prefs;

  @override
  Locale build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final locale = _prefs.getInt('locale');
    return switch (locale) {
      1 => L10n.fa,
      2 => L10n.en,
      _ => L10n.system,
    };
  }

  void changeLocale(Locale locale) {
    state = locale;
    switch (locale) {
      case L10n.fa:
        _prefs.setInt('locale', 1);
      case L10n.en:
        _prefs.setInt('locale', 2);
      default:
        _prefs.remove('locale');
    }
  }
}

@riverpod
class ThemeColorSetting extends _$ThemeColorSetting {
  dynamic _prefs;

  @override
  Color build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    final themeColor = _prefs.getInt('themeColor');
    return switch (themeColor) {
      1 => Colors.yellow,
      2 => Colors.pinkAccent,
      3 => Colors.green,
      4 => Colors.purple,
      5 => Colors.red,
      _ => Colors.lightBlue,
    };
  }

  void changeColor(Color color) {
    state = color;
    switch (color) {
      case Colors.yellow:
        _prefs.setInt('themeColor', 1);
      case Colors.pinkAccent:
        _prefs.setInt('themeColor', 2);
      case Colors.green:
        _prefs.setInt('themeColor', 3);
      case Colors.purple:
        _prefs.setInt('themeColor', 4);
      case Colors.red:
        _prefs.setInt('themeColor', 5);
      default:
        _prefs.remove('themeColor');
    }
  }

  String name() {
    switch (state) {
      case Colors.yellow:
        return 'yellow';
      case Colors.pinkAccent:
        return 'pink';
      case Colors.green:
        return 'green';
      case Colors.purple:
        return 'purple';
      case Colors.red:
        return 'red';
      default:
        return 'blue';
    }
  }
}

@riverpod
class CalendarTypeSetting extends _$CalendarTypeSetting {
  late dynamic _prefs;

  @override
  CalendarType build() {
    _prefs = ref.read(sharedPreferencesProvider);
    final calendar = _prefs.getInt('calendarType');
    return switch (calendar) {
      1 => CalendarType.persian,
      _ => CalendarType.gregorian,
    };
  }

  void changeType(CalendarType type) {
    state = type;
    switch (state) {
      case CalendarType.persian:
        _prefs.setInt('calendarType', 1);
      default:
        _prefs.remove('calendarType');
    }
  }
}

@riverpod
class SeenWelcomeScreen extends _$SeenWelcomeScreen {
  late dynamic _prefs;

  @override
  bool build() {
    _prefs = ref.read(sharedPreferencesProvider);
    final seen = _prefs.getBool('seenWelcomeScreen');
    return seen ?? false;
  }

  void toggle() {
    state = !state;
    _prefs.setBool('seenWelcomeScreen', state);
  }
}

import 'dart:io';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacher_mate/applications/state_management/settings_provider.dart';
import 'package:teacher_mate/l10n/l10n.dart';
import 'package:teacher_mate/presentation/helpers/tm_date_formatter.dart';

part 'date_formatter_provider.g.dart';

@riverpod
TMDateFormatter tMDateFormatter(Ref ref) {
  final calendarType = ref.watch(calendarTypeSettingProvider);
  final locale = ref.watch(localeSettingProvider);
  final formatterLocale =
      locale != L10n.system
          ? locale
          : Locale(Platform.localeName.substring(0, 2));
  return TMDateFormatter(calendarType, formatterLocale);
}

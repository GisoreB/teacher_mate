import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:teacher_mate/infrastructure/data/calendar_type.dart';



class TMDateFormatter {
  final CalendarType calendarType;
  final Locale locale;

  TMDateFormatter(this.calendarType, this.locale);

  String formatFull(DateTime dateTime) {
    return switch (calendarType) {
      CalendarType.persian => _jalaliFullFormat(Jalali.fromDateTime(dateTime)),
      CalendarType.gregorian => _gregorianFullFormat(dateTime),
    };
  }

  String formatShort(DateTime dateTime) {
    return switch (calendarType) {
      CalendarType.persian => _jalaliShortFormat(Jalali.fromDateTime(dateTime)),
      CalendarType.gregorian => _gregorianShortFormat(dateTime),
    };
  }

  String formatCompact(DateTime dateTime) {
    return switch (calendarType) {
      CalendarType.persian => _jalaliCompactFormat(Jalali.fromDateTime(dateTime)),
      CalendarType.gregorian => _gregorianCompactFormat(dateTime),
    };
  }

  // --- Internal methods ---

  String _jalaliFullFormat(Jalali d) {
    final f = d.formatter;
    final weekday = _localizedWeekday(d);
    final month = _localizedMonth(f.mm);
    return _localizeDigits('$weekday ${f.d} $month ${f.yyyy} - ${f.tHH}:${f.tMM}');
  }

  String _jalaliShortFormat(Jalali d) {
    final f = d.formatter;
    final weekday = _localizedWeekday(d);
    final month = _localizedMonth(f.mm);
    return _localizeDigits('$weekday ${f.d} $month - ${f.tHH}:${f.tMM}');
  }

  String _jalaliCompactFormat(Jalali d) {
    return _localizeDigits(d.formatCompactDate());
  }

  // --- Gregorian uses intl with locale ---
  String _gregorianFullFormat(DateTime d) {
    return DateFormat(
      'EEE, MMM d, yyyy – hh:mm a',
      locale.languageCode,
    ).format(d);
  }

  String _gregorianShortFormat(DateTime d) {
    return DateFormat('EEE, MMM d – hh:mm a', locale.languageCode).format(d);
  }

  String _gregorianCompactFormat(DateTime d) {
    return DateFormat('yyyy/MM/dd', locale.languageCode).format(d);
  }

  // --- Jalali localization (manual) ---
  String _localizeDigits(String input) {
    if (locale.languageCode == 'fa') {
      const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      const persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

      for (var i = 0; i < western.length; i++) {
        input = input.replaceAll(western[i], persian[i]);
      }
    }

    return input;
  }

  // Weekday and month index start from 1
  String _localizedWeekday(Jalali date) {
    const weekdaysFa = [
      'شنبه',
      'یک شنبه',
      'دو شنبه',
      'سه شنبه',
      'چهار شنبه',
      'پنج شنبه',
      'جمعه',
    ];
    const weekdaysEn = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    return locale.languageCode == 'fa'
        ? weekdaysFa[date.weekDay - 1]
        : weekdaysEn[date.weekDay - 1];
  }

  String _localizedMonth(String mmStr) {
    final int mm = int.tryParse(mmStr) ?? 1; // Defaults to 1 if parsing fails
    const monthsFa = [
      'فروردین',
      'اردیبهشت',
      'خرداد',
      'تیر',
      'مرداد',
      'شهریور',
      'مهر',
      'آبان',
      'آذر',
      'دی',
      'بهمن',
      'اسفند',
    ];
    const monthsEn = [
      'Farvardin',
      'Ordibehesht',
      'Khordad',
      'Tir',
      'Mordad',
      'Shahrivar',
      'Mehr',
      'Aban',
      'Azar',
      'Dey',
      'Bahman',
      'Esfand',
    ];
    return locale.languageCode == 'fa'
        ? monthsFa[(mm - 1).clamp(0, 11)]
        : monthsEn[(mm - 1).clamp(0, 11)];
  }
}

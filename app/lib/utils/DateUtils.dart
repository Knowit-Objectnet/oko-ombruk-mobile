import 'package:flutter/material.dart';

enum TimeType { Start, End }

enum Weekdays { monday, tuesday, wednesday, thursday, friday }

abstract class DateUtils {
  static final Map<String, int> jsonWeekdays = {
    "MONDAY": 1,
    "TUESDAY": 2,
    "WEDNESDAY": 3,
    "THURSDAY": 4,
    "FRIDAY": 5,
    "SATURDAY": 6,
    "SUNDAY": 7,
  };

  static final Map<int, String> jsonWeekdaysAsValues = Map.fromEntries(
    jsonWeekdays.entries.map((e) => MapEntry(e.value, e.key)),
  );

  static final Map<int, String> weekdaysShort = {
    1: 'Man',
    2: 'Tir',
    3: 'Ons',
    4: 'Tors',
    5: 'Fre',
    6: 'Lør',
    7: 'Søn'
  };

  static final Map<int, String> weekdaysLong = {
    1: 'Mandag',
    2: 'Tirsdag',
    3: 'Onsdag',
    4: 'Torsdag',
    5: 'Fredag',
    6: 'Lørdag',
    7: 'Søndag'
  };

  static final Map<int, String> months = {
    1: 'Januar',
    2: 'Februar',
    3: 'Mars',
    4: 'April',
    5: 'Mai',
    6: 'Juni',
    7: 'Juli',
    8: 'August',
    9: 'September',
    10: 'Oktober',
    11: 'November',
    12: 'Desember',
  };

  static final Map<int, String> monthsShort = {
    1: 'JAN',
    2: 'FEB',
    3: 'MAR',
    4: 'APR',
    5: 'MAI',
    6: 'JUN',
    7: 'JUL',
    8: 'AUG',
    9: 'SEP',
    10: 'OKT',
    11: 'NOV',
    12: 'DES',
  };

  static Weekdays toWeekday(int i) {
    switch (i) {
      case 1:
        return Weekdays.monday;
        break;
      case 2:
        return Weekdays.tuesday;
        break;
      case 3:
        return Weekdays.wednesday;
        break;
      case 4:
        return Weekdays.thursday;
        break;
      case 5:
        return Weekdays.friday;
        break;
      default:
        throw Exception("Not a weekday!");
    }
  }

  static String getDMYString(DateTime dateTime) =>
      " ${dateTime.day.toString()}. ${months[dateTime.month]} ${dateTime.year.toString()}";

  /// Removes the microseconds from [DateTime] so that the backend don't whine
  static String getDateString(DateTime dateTime) =>
      dateTime?.toIso8601String()?.substring(0, 19);

  static DateTime fromTimeOfDay(DateTime date, TimeOfDay timeOfDay) =>
      DateTime.utc(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute);

  static String timeOfDayToString(TimeOfDay time) =>
      "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

  static TimeOfDay getTime(DateTime date) =>
      TimeOfDay(hour: date.hour, minute: date.minute);

  static String getTimeString(DateTime date) =>
      timeOfDayToString(getTime(date));

  static bool isSameDayAs(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

abstract class DateUtils {
  /// Removes the microseconds from [DateTime] so that the backend don't whine
  static String getDateString(DateTime dateTime) =>
      dateTime?.toIso8601String()?.substring(0, 19);
}

import 'package:ombruk/utils/DateUtils.dart';

class RecurrenceRule {
  final List<Weekdays> days;
  final DateTime until;
  final int interval;
  final int count;
  RecurrenceRule({
    this.days,
    this.until,
    this.interval,
    this.count,
  });
}

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/WeightReport.dart';

class CalendarEventWithWeight {
  final CalendarEvent calendarEvent;
  final WeightReport weightReport;

  CalendarEventWithWeight(this.calendarEvent, this.weightReport);
}

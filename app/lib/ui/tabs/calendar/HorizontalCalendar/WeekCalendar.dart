import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class WeekCalendar extends StatefulWidget {
  WeekCalendar({Key key, @required this.dateTime, @required this.events})
      : super(key: key);

  final DateTime dateTime;
  final List<CalendarEvent> events;

  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  DateTime now = DateTime.now();
  DateTime dateNow;

  @override
  void initState() {
    dateNow = DateTime(now.year, now.month, now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DayView(
      date: widget.dateTime,
      userZoomable: false,
      events: widget.events
          .map((e) => FlutterWeekViewEvent(
              title: "tittel",
              description: "beskrivelse",
              start: e.startDateTime,
              end: e.endDateTime))
          .toList(),
    );
  }
}

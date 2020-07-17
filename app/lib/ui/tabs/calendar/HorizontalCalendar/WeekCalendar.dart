import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

import 'package:ombruk/globals.dart' as globals;

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
      minimumTime: HourMinute(hour: 7),
      maximumTime: HourMinute(hour: 21),
      style: DayViewStyle(
        dayBarHeight: 0.0, // Hides dayBar hack
        backgroundColor: globals.osloWhite,
        hourRowHeight: 55.0,
      ),
      events: widget.events
          .map((e) => FlutterWeekViewEvent(
              backgroundColor: globals.osloLightBeige,
              textStyle: TextStyle(color: globals.osloBlack),
              title: e.partner?.name ?? '',
              description: e.station?.name ?? '',
              start: e.startDateTime,
              end: e.endDateTime))
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

class WeekCalendar extends StatefulWidget {
  WeekCalendar({Key key, @required this.dateTime}) : super(key: key);

  final DateTime dateTime;

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
      events: [
        FlutterWeekViewEvent(
          title: 'An event 1',
          description: 'A description 1',
          start: dateNow.subtract(Duration(hours: 1)),
          end: dateNow.add(Duration(hours: 18, minutes: 30)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 2',
          description: 'A description 2',
          start: dateNow.add(Duration(hours: 19)),
          end: dateNow.add(Duration(hours: 22)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 3',
          description: 'A description 3',
          start: dateNow.add(Duration(hours: 23, minutes: 30)),
          end: dateNow.add(Duration(hours: 25, minutes: 30)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 4',
          description: 'A description 4',
          start: dateNow.add(Duration(hours: 20)),
          end: dateNow.add(Duration(hours: 21)),
        ),
        FlutterWeekViewEvent(
          title: 'An event 5',
          description: 'A description 5',
          start: dateNow.add(Duration(hours: 20)),
          end: dateNow.add(Duration(hours: 21)),
        ),
      ],
    );
  }
}

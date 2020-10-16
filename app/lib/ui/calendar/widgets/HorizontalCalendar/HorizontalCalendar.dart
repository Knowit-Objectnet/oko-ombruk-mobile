import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/calendar/widgets/HorizontalCalendar/DateText.dart';
import 'package:ombruk/ui/calendar/widgets/HorizontalCalendar/DayScroller.dart';
import 'package:ombruk/ui/calendar/widgets/HorizontalCalendar/WeekCalendar.dart';

class HorizontalCalendar extends StatefulWidget {
  HorizontalCalendar({Key key, @required this.events}) : super(key: key);

  final List<CalendarEvent> events;
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime _selectedDay;

  @override
  void initState() {
    setState(() {
      _selectedDay = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        DayScroller(
          selectDay: (DateTime dateTime) {
            setState(() {
              _selectedDay = dateTime;
            });
          },
          selectedDay: _selectedDay,
        ),
        DateText(dateTime: _selectedDay),
        Expanded(
            child: WeekCalendar(dateTime: _selectedDay, events: widget.events)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/DateText.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/DayScroller.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/StationFilter.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/WeekCalendar.dart';

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  DateTime _selectedDay;

  // Remove
  final List<String> stations = [
    'Haraldrud',
    'Smestad',
    'Grønmo',
    // 'Some',
    // 'Stasjon 4'
  ];

  @override
  void initState() {
    setState(() {
      _selectedDay = DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Column(
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
        Expanded(child: WeekCalendar()),
        StationFilter(stations: stations)
      ],
    ));
  }
}

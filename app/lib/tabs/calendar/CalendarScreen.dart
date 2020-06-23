import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/DayScroller.dart';
import 'package:ombruk/tabs/calendar/StationFilter.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Column(children: <Widget>[
      DayScroller(),
      Center(child: Text('Calendar')),
      StationFilter()
    ])));
  }
}

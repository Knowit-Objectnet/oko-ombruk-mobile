import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/DayScroller.dart';
import 'package:ombruk/tabs/calendar/StationFilter.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // Remove
  final List<String> stations = [
    'Haraldrud',
    'Smestad',
    'Grønmo',
    'Some',
    'Stasjon 4'
  ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          DayScroller(),
          Center(child: Text('Calendar')),
          StationFilter(stations: stations)
        ])));
  }
}

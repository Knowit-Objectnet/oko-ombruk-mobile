import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool _showHorizontalCalendar = true;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () => setState(() {
                  _showHorizontalCalendar = !_showHorizontalCalendar;
                }),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: null,
              )
            ],
          ),
          Expanded(child: HorizontalCalendar())
        ])));
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/calendar/ExtraHentingPopup/ExtraHentingDialog.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';

class CalendarScreen extends StatefulWidget {
  final List<CalendarEvent> events;

  CalendarScreen({@required this.events}) : assert(events != null);

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
                icon: _showHorizontalCalendar
                    ? Icon(Icons.list)
                    : Icon(Icons.calendar_today),
                onPressed: () => setState(() {
                  _showHorizontalCalendar = !_showHorizontalCalendar;
                }),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => ExtraHentingDialog()),
              )
            ],
          ),
          Expanded(
              child: _showHorizontalCalendar
                  ? HorizontalCalendar(events: widget.events)
                  : VerticalCalendar(events: widget.events))
        ])));
  }
}

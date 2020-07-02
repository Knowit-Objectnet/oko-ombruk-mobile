import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/calendar/ExtraHentingPopup/ExtraHentingDialog.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';

// To be removed
List<CalendarEvent> events = [
  CalendarEvent(
      "Fretex",
      "beskrivelse",
      DateTime.now().subtract(Duration(hours: 5)),
      DateTime.now().subtract(Duration(hours: 1)),
      3),
  CalendarEvent("frigo", "noe", DateTime.now().add(Duration(hours: 1)),
      DateTime.now().add(Duration(hours: 3)), 6),
  CalendarEvent(
      "Oslo kollega",
      ".......",
      DateTime.now().add(Duration(hours: 2)),
      DateTime.now().add(Duration(hours: 6)),
      0),
  CalendarEvent(
      "Ny dag",
      "Beskrivelse av opplegget",
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 1, hours: 1)),
      9),
];

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
                  ? HorizontalCalendar(events: events)
                  : VerticalCalendar(events: events))
        ])));
  }
}

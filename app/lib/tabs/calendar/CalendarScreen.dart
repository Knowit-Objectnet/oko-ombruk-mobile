import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/tabs/calendar/ExtraHentingPopup/ExtraHentingDialog.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';

// To be removed
List<CalendarEvent> events = [
  CalendarEvent(
      "Fretex",
      "beskrivelse",
      DateTime.now().subtract(Duration(hours: 2)),
      DateTime.now().subtract(Duration(hours: 1))),
  CalendarEvent("frigo", "noe", DateTime.now().add(Duration(hours: 1)),
      DateTime.now().add(Duration(hours: 3))),
  CalendarEvent(
      "Oslo kollega",
      ".......",
      DateTime.now().add(Duration(hours: 2)),
      DateTime.now().add(Duration(hours: 6))),
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
                icon: Icon(Icons.list),
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
                  : VerticalCalendar())
        ])));
  }
}

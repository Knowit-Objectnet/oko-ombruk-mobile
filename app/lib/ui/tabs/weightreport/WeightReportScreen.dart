import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/models/events.json';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_load_local_json/events.dart';

List<CalendarEvent> events = [
  CalendarEvent(
      "Fretex",
      "beskrivelse",
      DateTime.now().subtract(Duration(hours: 5)),
      DateTime.now().subtract(Duration(hours: 1)),
      6),
  CalendarEvent("frigo", "noe", DateTime.now().add(Duration(hours: 1)),
      DateTime.now().add(Duration(hours: 3)), 7),
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
      0),
];

class WeightReportScreen extends StatefulWidget {
  WeightReportScreen({Key key}) : super(key: key);
  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9C66B),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Siste uttak',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF8274),
                          ),
                          child: Text('Dato'),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 0),
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Vektuttak (kg)',
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                BlacklistingTextInputFormatter(
                                    new RegExp('[\\-|\\ ]'))
                              ],
                            )),
                        RawMaterialButton(
                            fillColor: Color(0xFFFF8274),
                            child: Text('OK'),
                            onPressed: _submit,
                            shape: CircleBorder())
                      ]),
                  Text('Tidligere uttak',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Container(
                      height: 200,
                      width: 400,
                      child: ListView.builder(
                          itemCount: events == null ? 0 : events.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 5),
                                child: Row(children: <Widget>[
                                  Container(
                                      width: 101,
                                      height: 37,
                                      color: (events[index].weight != 0)
                                          ? Color(0xFF43F8B6)
                                          : Color(0xFFFF8274),
                                      child:
                                          Text(events[index].start.toString())),
                                  Container(
                                      width: 187,
                                      height: 37,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 5),
                                      color: Colors.white,
                                      child: ((events[index].weight != 0)
                                          ? Text(
                                              events[index].weight.toString())
                                          : TextField(
                                              decoration: InputDecoration(
                                                  hintText: 'Vekt'))))
                                ]));
                          })
                      //   GroupedListView<CalendarEvent, DateTime>(
                      // elements: widget.events,
                      // groupBy: (CalendarEvent event) {
                      //   // Sort without time
                      //   DateTime date = event.start;
                      //   DateTime sortDate = DateTime.utc(date.year, date.month, date.day);
                      //   return sortDate;
                      // },
                      // groupSeparatorBuilder: (DateTime groupByValue) => Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      //   ),
                      //   itemBuilder: (_, CalendarEvent event) => Container(
                      //     color: Colors.grey[200],
                      //     ),)
                      )
                ])));
  }

  void _submit() {}
}

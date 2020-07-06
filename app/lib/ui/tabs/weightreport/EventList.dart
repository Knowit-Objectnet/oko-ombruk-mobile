import 'package:flutter/material.dart';
import 'package:ombruk/models/WeightEvent.dart';
import 'package:flutter/foundation.dart';
import 'package:ombruk/globals.dart' as globals;

class EventList extends StatelessWidget {
  final List<WeightEvent> events;
  EventList({Key key, this.events}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 400,
        child: ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                                color: (events[index].weight != 0)
                                    ? Color(0xFF43F8B6)
                                    : Color(0xFFFF8274),
                                child: Text(events[index].start.day.toString() +
                                    '. ' +
                                    globals.months[events[index].start.month]
                                        .toString() +
                                    ', ' +
                                    globals.weekdaysShort[
                                            events[index].start.weekday]
                                        .toLowerCase() +
                                    '\n' +
                                    events[index]
                                        .start
                                        .hour
                                        .toString()
                                        .padLeft(2, "0") +
                                    ':' +
                                    events[index]
                                        .start
                                        .minute
                                        .toString()
                                        .padLeft(2, "0") +
                                    ' - ' +
                                    events[index]
                                        .start
                                        .hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    events[index]
                                        .start
                                        .minute
                                        .toString()
                                        .padLeft(2, '0'))))),
                    Expanded(
                        flex: 2,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 5),
                                color: Colors.white,
                                child: ((events[index].weight != 0)
                                    ? Text(events[index].weight.toString())
                                    : TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Vekt'))))))
                  ]));
            }));
  }
}

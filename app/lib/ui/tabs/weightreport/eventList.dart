import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:flutter/foundation.dart';

class EventList extends StatelessWidget {
  final List<CalendarEvent> events;
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
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
                  child: Row(children: <Widget>[
                    Container(
                        width: 101,
                        height: 37,
                        color: (events[index].weight != 0)
                            ? Color(0xFF43F8B6)
                            : Color(0xFFFF8274),
                        child: Text(events[index].start.toString())),
                    Container(
                        width: 187,
                        height: 37,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24.0, vertical: 5),
                        color: Colors.white,
                        child: ((events[index].weight != 0)
                            ? Text(events[index].weight.toString())
                            : TextField(
                                decoration: InputDecoration(hintText: 'Vekt'))))
                  ]));
            }));
  }
}

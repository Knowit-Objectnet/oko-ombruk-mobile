import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ombruk/globals.dart' as globals;

class VerticalCalendar extends StatefulWidget {
  VerticalCalendar({Key key, @required this.events}) : super(key: key);
  final List<CalendarEvent> events;

  @override
  _VerticalCalendarState createState() => _VerticalCalendarState();
}

class _VerticalCalendarState extends State<VerticalCalendar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Groups the list on dates, with pretty text dividers
    return GroupedListView<CalendarEvent, DateTime>(
      elements: widget.events,
      groupBy: (CalendarEvent event) {
        // Sort without time
        DateTime date = event.startDateTime;
        DateTime sortDate = DateTime.utc(date.year, date.month, date.day);
        return sortDate;
      },
      groupSeparatorBuilder: (DateTime groupByValue) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: _dateText(groupByValue)),
      itemBuilder: (_, CalendarEvent event) => Container(
          color: Colors.grey[200],
          child: ExpansionTile(
            title: Row(
              children: <Widget>[
                _timeText(event.startDateTime, event.endDateTime),
                VerticalDivider(thickness: 100, color: Colors.black),
                Text(event.partner?.name ?? '')
              ],
            ),
            children: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                      onPressed: () => null,
                      color: Colors.red,
                      child: Text('Avbryt')),
                  FlatButton(
                      onPressed: () => null,
                      color: Colors.green,
                      child: Text('Godkjenn'))
                ],
              )
            ],
          )),
    );
  }

  Widget _timeText(DateTime start, DateTime end) {
    return Text(start.hour.toString().padLeft(2, '0') +
        ':' +
        start.minute.toString().padLeft(2, '0') +
        '-' +
        end.hour.toString().padLeft(2, '0') +
        ':' +
        end.minute.toString().padLeft(2, '0'));
  }

  Widget _dateText(DateTime dateTime) {
    return Text(
        globals.weekdaysLong[dateTime.weekday] +
            ' ' +
            dateTime.day.toString() +
            '. ' +
            globals.months[dateTime.month],
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold));
  }
}

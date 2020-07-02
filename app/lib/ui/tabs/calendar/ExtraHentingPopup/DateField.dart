import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class DateField extends StatelessWidget {
  DateField({Key key, @required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Icon(Icons.calendar_today),
          Text(' ' +
              globals.months[date.month] +
              ' ' +
              date.day.toString() +
              ', ' +
              date.year.toString())
        ]));
  }
}

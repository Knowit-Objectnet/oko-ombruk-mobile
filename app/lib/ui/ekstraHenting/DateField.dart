import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/utils/DateUtils.dart';

class DateField extends StatelessWidget {
  DateField({Key key, @required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(children: <Widget>[
          Image.asset('assets/icons/kalender.png', height: 20, width: 20),
          Text(' ' +
              DateUtils.months[date.month] +
              ' ' +
              date.day.toString() +
              ', ' +
              date.year.toString())
        ]));
  }
}

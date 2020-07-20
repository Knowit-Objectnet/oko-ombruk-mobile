import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

class DateText extends StatelessWidget {
  DateText({Key key, @required this.dateTime}) : super(key: key);

  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold, color: customColors.osloBlack),
            children: <TextSpan>[
          TextSpan(
              text: globals.weekdaysLong[dateTime.weekday],
              style: TextStyle(fontSize: 16)),
          TextSpan(
              text: ' ' +
                  dateTime.day.toString() +
                  '. ' +
                  globals.months[dateTime.month] +
                  ' ' +
                  dateTime.year.toString(),
              style: TextStyle(fontSize: 12.0)),
        ]));
  }
}

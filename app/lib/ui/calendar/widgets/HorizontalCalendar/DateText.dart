import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

class DateText extends StatelessWidget {
  DateText({Key key, @required this.dateTime}) : super(key: key);

  final DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: TextStyle(
                fontWeight: FontWeight.bold, color: CustomColors.osloBlack),
            children: <TextSpan>[
          TextSpan(
              text: DateUtils.weekdaysLong[dateTime.weekday],
              style: TextStyle(fontSize: 16)),
          TextSpan(
              //TODO: Can be converted to DateUtils call.
              text: ' ' +
                  dateTime.day.toString() +
                  '. ' +
                  DateUtils.months[dateTime.month] +
                  ' ' +
                  dateTime.year.toString(),
              style: TextStyle(fontSize: 12.0)),
        ]));
  }
}

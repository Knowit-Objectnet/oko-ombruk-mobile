import 'package:flutter/material.dart';

import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

class DateTimeBox extends StatelessWidget {
  final WeightReport weightReport;
  final bool isReported;

  DateTimeBox({Key key, @required this.weightReport, @required this.isReported})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.0),
        color: isReported ? customColors.osloGreen : customColors.osloRed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(_getDate(weightReport.startDateTime)),
            Text(
                _getTime(weightReport.startDateTime, weightReport.endDateTime)),
          ],
        ));
  }

  String _getDate(DateTime dateTime) {
    return dateTime.day.toString() +
        '. ' +
        globals.months[dateTime.month].toString() +
        ', ' +
        globals.weekdaysShort[dateTime.weekday].toLowerCase();
  }

  String _getTime(DateTime start, DateTime end) {
    return start.hour.toString().padLeft(2, "0") +
        ':' +
        start.minute.toString().padLeft(2, "0") +
        ' - ' +
        end.hour.toString().padLeft(2, '0') +
        ':' +
        end.minute.toString().padLeft(2, '0');
  }
}

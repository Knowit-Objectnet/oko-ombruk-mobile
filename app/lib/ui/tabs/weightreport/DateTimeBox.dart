import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/models/WeightEvent.dart';

class DateTimeBox extends StatelessWidget {
  DateTimeBox({Key key, @required this.weightEvent}) : super(key: key);

  final WeightEvent weightEvent;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: weightEvent.weight != null ? globals.osloGreen : globals.osloRed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(_getDate(weightEvent.start)),
            Text(_getTime(weightEvent.start, weightEvent.end))
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

import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  DateField({Key key, @required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Text(date.month.toString() + ':' + date.day.toString());
  }
}

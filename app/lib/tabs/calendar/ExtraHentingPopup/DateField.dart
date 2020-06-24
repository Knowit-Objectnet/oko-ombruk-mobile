import 'package:flutter/material.dart';


class DateField extends StatelessWidget {
  DateField({Key key, @required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          Icon(Icons.calendar_today),
          Text(date.month.toString() + ':' + date.day.toString())
        ]

    ));
      
    }
}

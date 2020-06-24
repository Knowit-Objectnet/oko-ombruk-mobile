import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  TimeField({Key key, @required this.time}) : super(key: key);

  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          Icon(Icons.access_time),
          Text(time.hour.toString() + ':' + time.hour.toString())
        ]

    ));
  }
}

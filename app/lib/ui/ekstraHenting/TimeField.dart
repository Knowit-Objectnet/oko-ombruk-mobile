import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  TimeField({Key key, @required this.time}) : super(key: key);

  final TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    return Text(" " +
        time.hour.toString().padLeft(2, "0") +
        ':' +
        time.minute.toString().padLeft(2, "0"));
  }
}

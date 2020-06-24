import 'package:flutter/material.dart';

class DurationField extends StatelessWidget {
  DurationField({Key key, @required this.dur}) : super(key: key);

  final TimeOfDay dur;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.all(2.0), 
      child: Text(" "+dur.hour.toString().padLeft(2, "0")+ ':' + dur.minute.toString().padLeft(2, "0")));
  }
}

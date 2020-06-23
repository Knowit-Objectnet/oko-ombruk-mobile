import 'package:flutter/material.dart';

class DateButton extends StatefulWidget {
  DateButton({Key key, @required this.dateTime}) : super(key: key);

  final DateTime dateTime;

  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  final Map<int, String> weekdays = {
    1: 'Man',
    2: 'Tir',
    3: 'Ons',
    4: 'Tors',
    5: 'Fre',
    6: 'Lør',
    7: 'Søn'
  };

  @override
  Widget build(BuildContext context) {
    var weekday = weekdays[widget.dateTime.weekday];
    return GestureDetector(
      onTap: () => _datePressed(),
      child: Column(
        children: <Widget>[
          Text('$weekday', style: TextStyle(fontSize: 12.0)),
          Text(
            '${widget.dateTime.day}',
            style: TextStyle(fontSize: 20.0),
          )
        ],
      ),
    );
  }

  void _datePressed() {
    print(widget.dateTime);
  }
}

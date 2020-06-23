import 'package:flutter/material.dart';

class DateButton extends StatefulWidget {
  DateButton({Key key, @required this.index}) : super(key: key);

  final int index;

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
    var date = DateTime.now().add(Duration(days: widget.index));
    var day = date.day;
    // var month = date.month;
    var weekday = weekdays[date.weekday];
    return (Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: () => _datePressed(),
          child: Column(
            children: <Widget>[
              Text('$weekday', style: TextStyle(fontSize: 12.0)),
              Text(
                '$day',
                style: TextStyle(fontSize: 20.0),
              )
            ],
          ),
        )));
  }

  void _datePressed() {
    print(widget.index);
  }
}

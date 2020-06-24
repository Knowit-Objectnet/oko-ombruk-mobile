import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class DateButton extends StatefulWidget {
  DateButton(
      {Key key,
      @required this.dateTime,
      @required this.selectDay,
      @required this.isSelected})
      : super(key: key);

  final DateTime dateTime;
  final Function(DateTime) selectDay;
  final bool isSelected;

  @override
  _DateButtonState createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  @override
  Widget build(BuildContext context) {
    String weekday = globals.weekdaysShort[widget.dateTime.weekday];
    return Expanded(
        // TODO: The GestureDetector doesn't fill the entire parent, only the child, so the onTap may be working so so
        child: GestureDetector(
            onTap: () => _datePressed(), child: _numberWidget(weekday)));
  }

  Widget _numberWidget(String weekday) {
    if (widget.isSelected) {
      return Column(
        children: <Widget>[
          Text('$weekday', style: TextStyle(fontSize: 12.0, color: Colors.red)),
          CircleAvatar(
              backgroundColor: Colors.red,
              radius: 16.0,
              child: Text(
                '${widget.dateTime.day}',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ))
        ],
      );
    }

    return Column(
      children: <Widget>[
        Text('$weekday', style: TextStyle(fontSize: 12.0)),
        Text(
          '${widget.dateTime.day}',
          style: TextStyle(fontSize: 20.0),
        )
      ],
    );
  }

  void _datePressed() {
    widget.selectDay(widget.dateTime);
  }
}

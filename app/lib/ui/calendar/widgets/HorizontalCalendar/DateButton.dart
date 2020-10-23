import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

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
  Color _backgroundColor;
  Color _textColor;

  @override
  Widget build(BuildContext context) {
    _backgroundColor =
        widget.isSelected ? CustomColors.osloDarkBlue : CustomColors.osloWhite;
    _textColor =
        widget.isSelected ? CustomColors.osloWhite : CustomColors.osloBlack;

    String weekday = DateUtils.weekdaysShort[widget.dateTime.weekday];
    return Expanded(
        // TODO: The GestureDetector doesn't fill the entire parent, only the child, so the onTap may be working so so
        child: GestureDetector(
            onTap: () => _datePressed(), child: _numberWidget(weekday)));
  }

  Widget _numberWidget(String weekday) {
    return Column(
      children: <Widget>[
        Text(
          '$weekday',
          style: TextStyle(fontSize: 12.0, color: CustomColors.osloBlack),
        ),
        CircleAvatar(
            backgroundColor: _backgroundColor,
            radius: 16.0,
            child: Text(
              '${widget.dateTime.day}',
              style: TextStyle(fontSize: 16.0, color: _textColor),
            ))
      ],
    );
  }

  void _datePressed() {
    widget.selectDay(widget.dateTime);
  }
}
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

class DatePicker extends StatelessWidget {
  final DateTime dateTime;
  final ValueChanged<DateTime> dateChanged;
  final Color backgroundColor;
  final Color borderColor;

  DatePicker(
      {@required this.dateTime,
      @required this.dateChanged,
      this.backgroundColor = customColors.osloWhite,
      this.borderColor = customColors.osloLightBlue})
      : assert(dateTime != null),
        assert(dateChanged != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 2.0, color: borderColor)),
        child: Text(globals.months[dateTime.month].substring(0, 3) +
            ' ' +
            dateTime.day.toString() +
            ', ' +
            dateTime.year.toString()),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateTime) {
      dateChanged(picked);
    }
  }
}

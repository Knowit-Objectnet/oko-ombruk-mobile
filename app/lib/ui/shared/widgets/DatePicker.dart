import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

class DatePicker extends StatelessWidget {
  final DateTime dateTime;
  final ValueChanged<DateTime> dateChanged;
  final Color backgroundColor;
  final Color borderColor;
  final bool disabled;

  DatePicker({
    @required this.dateTime,
    @required this.dateChanged,
    this.backgroundColor = CustomColors.osloWhite,
    this.borderColor = CustomColors.osloLightBlue,
    this.disabled = false,
  })  : assert(dateTime != null),
        assert(dateChanged != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => disabled ? null : _selectDate(context),
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: borderColor != null && !disabled
                ? Border.all(width: 2.0, color: borderColor)
                : null),
        child: Text(
          DateUtils.months[dateTime.month].substring(0, 3) +
              ' ' +
              dateTime.day.toString() +
              ', ' +
              dateTime.year.toString(),
          style: TextStyle(fontSize: 18.0),
        ),
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

import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

class DateButton extends StatelessWidget {
  final DateTime dateTime;
  final Function(DateTime) onDateChanged;
  final bool isSelected;
  final bool disabled;

  DateButton({
    @required this.dateTime,
    @required this.onDateChanged,
    this.isSelected = false,
    this.disabled = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => disabled ? null : onDateChanged(dateTime),
      child: Column(
        children: [
          Text(
            DateUtils.weekdaysShort[dateTime.weekday],
            style: TextStyle(fontSize: 12.0, color: CustomColors.osloBlack),
          ),
          CircleAvatar(
            backgroundColor: isSelected
                ? CustomColors.osloDarkBlue
                : disabled
                    ? Colors.grey[200]
                    : CustomColors.osloWhite,
            radius: 16.0,
            child: Text(
              '${dateTime.day}',
              style: TextStyle(
                fontSize: 16.0,
                color: isSelected
                    ? CustomColors.osloWhite
                    : CustomColors.osloBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

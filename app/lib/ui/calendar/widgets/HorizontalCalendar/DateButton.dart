import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

class DateButton extends StatelessWidget {
  final DateTime dateTime;
  final Function(DateTime) onDateChanged;
  final bool isSelected;

  DateButton({
    @required this.dateTime,
    @required this.onDateChanged,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDateChanged(dateTime),
      child: Column(
        children: [
          Text(
            DateUtils.weekdaysShort[dateTime.weekday],
            style: TextStyle(fontSize: 12.0, color: CustomColors.osloBlack),
          ),
          CircleAvatar(
            backgroundColor:
                isSelected ? CustomColors.osloDarkBlue : CustomColors.osloWhite,
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

import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

class WeekdayPicker extends StatelessWidget {
  final List<globals.Weekdays> selectedWeekdays;
  final Function(globals.Weekdays) weekdaysChanged;

  WeekdayPicker(
      {@required this.selectedWeekdays, @required this.weekdaysChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: globals.Weekdays.values
          .map(
            (e) => Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2.0, color: customColors.osloLightBlue)),
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text(_stringFromEnum(e)),
                  backgroundColor: selectedWeekdays.contains(e)
                      ? customColors.osloLightBlue
                      : customColors.osloWhite,
                  foregroundColor: customColors.osloBlack,
                ),
                onTap: () => weekdaysChanged(e),
                // shape: CircleBorder(),
                // padding: EdgeInsets.all(15.0),
                // child: Text(_stringFromEnum(e)),
              ),
            ),
          )
          .toList(),
    );
  }

  String _stringFromEnum(globals.Weekdays weekday) {
    switch (weekday) {
      case globals.Weekdays.monday:
        return 'M';
      case globals.Weekdays.tuesday:
        return 'Ti';
      case globals.Weekdays.wednesday:
        return 'O';
      case globals.Weekdays.thursday:
        return 'To';
      case globals.Weekdays.friday:
        return 'F';
      default:
        return '';
    }
  }
}

import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

class TimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> timeChanged;
  final Color backgroundColor;
  final Color borderColor;
  final int minTime;
  final int maxTime;

  TimePicker({
    @required this.selectedTime,
    @required this.timeChanged,
    this.backgroundColor = customColors.osloWhite,
    this.borderColor = customColors.osloLightBlue,
    this.minTime = 7,
    this.maxTime = 16,
  })  : assert(selectedTime != null),
        assert(timeChanged != null),
        assert(selectedTime.hour >= minTime),
        assert(selectedTime.hour <= maxTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 2.0, color: borderColor),
      ),
      child: DropdownButton<TimeOfDay>(
        value: selectedTime,
        onChanged: timeChanged,
        underline: Container(),
        isDense: true,
        items: _timeList()
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.hour.toString().padLeft(2, '0') +
                      ':' +
                      e.minute.toString().padLeft(2, '0')),
                ))
            .toList(),
      ),
    );
  }

  List<TimeOfDay> _timeList() {
    List<TimeOfDay> list = [];
    // The if statements adds an abnormal time (e.g. 12:37) to the list
    // an abnormal time has minutes != 0 minutes != 30
    if (selectedTime.hour < minTime) {
      list.add(selectedTime);
    }
    for (int i = minTime; i < maxTime; i++) {
      list.add(TimeOfDay(hour: i, minute: 0));
      if (selectedTime.hour == i &&
          selectedTime.minute > 0 &&
          selectedTime.minute < 30) {
        list.add(selectedTime);
      }
      list.add(TimeOfDay(hour: i, minute: 30));
      if (selectedTime.hour == i &&
          selectedTime.minute > 30 &&
          selectedTime.minute < 60) {
        list.add(selectedTime);
      }
    }
    if (selectedTime.hour >= maxTime) {
      list.add(selectedTime);
    }
    return list;
  }
}

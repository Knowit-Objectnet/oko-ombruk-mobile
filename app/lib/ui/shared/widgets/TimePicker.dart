import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/CustomPicker.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> timeChanged;
  final int minTime;
  final int maxTime;
  final bool disabled;
  final Color iconBackgroundColor;

  TimePicker({
    @required this.selectedTime,
    @required this.timeChanged,
    this.minTime = 7,
    this.maxTime = 16,
    this.iconBackgroundColor = CustomColors.osloLightBeige,
    this.disabled = false,
  })  : assert(selectedTime != null),
        assert(timeChanged != null),
        assert(selectedTime.hour >= minTime),
        assert(selectedTime.hour <= maxTime);

  @override
  Widget build(BuildContext context) {
    return CustomPicker<TimeOfDay>(
      disabled: disabled,
      disabledWidget: Text(
          selectedTime.hour.toString().padLeft(2, '0') +
              ':' +
              selectedTime.minute.toString().padLeft(2, '0'),
          style: TextStyle(fontSize: 18.0)),
      iconBackgroundColor: iconBackgroundColor,
      selectedValue: selectedTime,
      valueChanged: timeChanged,
      items: _timeList(),
      itemBuilder: (context, item) => DropdownMenuItem(
        value: item,
        child: Text(
          item.hour.toString().padLeft(2, '0') +
              ':' +
              item.minute.toString().padLeft(2, '0'),
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
    // return Container(
    //   padding: EdgeInsets.all(6.0),
    //   decoration: disabled
    //       ? null
    //       : BoxDecoration(
    //           color: backgroundColor,
    //           border: Border.all(width: 2.0, color: borderColor),
    //         ),
    //   child: disabled
    //       ? Text(
    //           selectedTime.hour.toString().padLeft(2, '0') +
    //               ':' +
    //               selectedTime.minute.toString().padLeft(2, '0'),
    //           style: TextStyle(fontSize: 16.0),
    //         )
    //       : DropdownButton<TimeOfDay>(
    //           value: selectedTime,
    //           onChanged: (time) => timeChanged(time),
    //           underline: Container(),
    //           isDense: true,
    //           items: _timeList()
    //               .map((e) => DropdownMenuItem(
    //                     value: e,
    //                     child: Text(e.hour.toString().padLeft(2, '0') +
    //                         ':' +
    //                         e.minute.toString().padLeft(2, '0')),
    //                   ))
    //               .toList(),
    //         ),
    // );
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

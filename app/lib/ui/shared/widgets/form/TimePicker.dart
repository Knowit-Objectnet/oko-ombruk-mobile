import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/form/CustomPickerFormField.dart';
import 'package:ombruk/utils/DateUtils.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> timeChanged;
  final int minTime;
  final int maxTime;
  final bool disabled;
  final Color iconBackgroundColor;
  final String Function(TimeOfDay) validator;
  final bool isExpanded;
  final EdgeInsets itemPadding;

  TimePicker({
    @required this.selectedTime,
    @required this.timeChanged,
    this.minTime = 7,
    this.maxTime = 16,
    this.iconBackgroundColor = CustomColors.osloLightBeige,
    this.validator,
    this.disabled = false,
    this.isExpanded = true,
    this.itemPadding = const EdgeInsets.all(0),
  })  : assert(selectedTime != null),
        assert(timeChanged != null);
  //assert(selectedTime.hour >= minTime),
  //assert(selectedTime.hour <= maxTime);

  @override
  Widget build(BuildContext context) {
    return CustomPickerFormField<TimeOfDay>(
      isExpanded: isExpanded,
      disabled: disabled,
      disabledWidget: Text(
        DateUtils.timeOfDayToString(selectedTime),
        style: TextStyle(fontSize: 18.0),
      ),
      iconBackgroundColor: iconBackgroundColor,
      selectedValue: selectedTime,
      valueChanged: timeChanged,
      validator: validator,
      items: _timeList(),
      itemBuilder: (context, item) => DropdownMenuItem(
        value: item,
        child: Padding(
          padding: itemPadding,
          child: Text(
            DateUtils.timeOfDayToString(item),
            style: TextStyle(fontSize: 16.0),
          ),
        ),
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

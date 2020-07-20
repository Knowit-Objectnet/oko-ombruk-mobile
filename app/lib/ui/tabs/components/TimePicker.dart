import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

class TimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> timeChanged;
  final Color backgroundColor;
  final Color borderColor;

  TimePicker({
    @required this.selectedTime,
    @required this.timeChanged,
    this.backgroundColor = customColors.osloWhite,
    this.borderColor = customColors.osloLightBlue,
  })  : assert(selectedTime != null),
        assert(timeChanged != null);

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
        hint: Text('Velg tidspunkt'),
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
    for (int i = 7; i < 16; i++) {
      list.add(TimeOfDay(hour: i, minute: 0));
      list.add(TimeOfDay(hour: i, minute: 30));
    }
    return list;
  }
}

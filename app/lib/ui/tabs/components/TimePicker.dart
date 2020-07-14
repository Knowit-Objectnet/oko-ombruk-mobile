import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class TimePicker extends StatelessWidget {
  final TimeOfDay selectedTime;
  final ValueChanged<TimeOfDay> timeChanged;
  final Color backgroundColor;
  final Color borderColor;

  TimePicker(
      {@required this.selectedTime,
      @required this.timeChanged,
      this.backgroundColor = globals.osloWhite,
      this.borderColor = globals.osloLightBlue})
      : assert(selectedTime != null),
        assert(timeChanged != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 2.0, color: borderColor)),
        child: Text(
          " " +
              selectedTime.hour.toString().padLeft(2, "0") +
              ':' +
              selectedTime.minute.toString().padLeft(2, "0"),
        ),
      ),
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedTime) {
      timeChanged(picked);
    }
  }
}

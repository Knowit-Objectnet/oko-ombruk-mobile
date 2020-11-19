import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

class WeekdayPicker extends StatelessWidget {
  final Set<int> selectedWeekdays;
  final Set<int> availableWeekdays;
  final Function(int) weekdaysChanged;

  WeekdayPicker({
    @required this.selectedWeekdays,
    @required this.availableWeekdays,
    @required this.weekdaysChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: DateUtils.weekdaysShort.entries
          .map(
            (e) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: availableWeekdays.contains(e.key)
                      ? CustomColors.osloBlue
                      : Colors.grey[300],
                ),
              ),
              child: GestureDetector(
                child: CircleAvatar(
                  child: Text(
                    e.value[0],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: !availableWeekdays.contains(e.key)
                      ? Colors.grey[300]
                      : selectedWeekdays.contains(e.key)
                          ? CustomColors.osloBlue
                          : CustomColors.osloWhite,
                  foregroundColor: CustomColors.osloBlack,
                ),
                onTap: () => availableWeekdays.contains(e.key)
                    ? weekdaysChanged(e.key)
                    : null,
              ),
            ),
          )
          .toList(),
    );
  }
}

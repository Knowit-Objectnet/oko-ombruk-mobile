import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/calendar/widgets/HorizontalCalendar/DayScrollerViewModel.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/utils/DateUtils.dart';

import 'DateButton.dart';

class DayScroller extends StatelessWidget {
  final Station station;
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  DayScroller({
    @required this.selectedDate,
    @required this.onDateChanged,
    @required this.station,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: DayScrollerViewModel(),
      builder: (context, DayScrollerViewModel model, child) => Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        height: 80,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: CustomColors.osloLightBlue,
              child: Text('Uke ${model.currentWeekNumber}'),
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  model.onPageChanged(index);
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, offset) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: DateUtils.weekdaysShort.entries.take(5).map(
                    (e) {
                      DateTime date = model.calculateDate(offset, e.key);
                      return DateButton(
                        dateTime: date,
                        disabled: !station.hours.containsKey(date.weekday),
                        onDateChanged: onDateChanged,
                        isSelected: DateUtils.isSameDayAs(date, selectedDate),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

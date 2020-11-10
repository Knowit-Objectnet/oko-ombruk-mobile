import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

import 'DateButton.dart';

class DayScroller extends StatefulWidget {
  final Station station;
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  DayScroller({
    @required this.selectedDate,
    @required this.onDateChanged,
    @required this.station,
  });
  @override
  _DayScrollerState createState() => _DayScrollerState();
}

class _DayScrollerState extends State<DayScroller> {
  int _currentWeekNumber;
  @override
  void initState() {
    super.initState();
    _currentWeekNumber = _calculateWeekNumber(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      height: 80,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            color: CustomColors.osloLightBlue,
            child: Text('Uke $_currentWeekNumber'),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                setState(() {
                  _currentWeekNumber = _calculateWeekNumber(index);
                });
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, offset) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: widget.station.hours.entries.map(
                  (e) {
                    DateTime date = _calculateDate(offset, e.key);
                    return DateButton(
                      dateTime: date,
                      onDateChanged: widget.onDateChanged,
                      isSelected:
                          DateUtils.isSameDayAs(date, widget.selectedDate),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _calculateWeekNumber(int index) {
    // Weekday calculation from https://en.wikipedia.org/wiki/ISO_week_date#Calculation
    DateTime newWeek = DateTime.now().add(Duration(days: 7 * index));
    int dayOfYear = int.parse(DateFormat('D').format(newWeek));
    return ((dayOfYear - newWeek.weekday + 10) / 7).floor();
  }

  DateTime _calculateDate(int offset, int dayOfWeek) {
    DateTime now = DateTime.now();
    return now.add(Duration(days: (7 * offset) + dayOfWeek - now.weekday));
  }
}

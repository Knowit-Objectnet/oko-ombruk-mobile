import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/DateButton.dart';

class DayScroller extends StatefulWidget {
  @override
  _DayScrollerState createState() => _DayScrollerState();
}

class _DayScrollerState extends State<DayScroller> {
  final controller = PageController(initialPage: 1);
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      height: 70,
      child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, weekOffset) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _weekdays(weekOffset),
              )),
    );
  }

  // Builds a 7 day list of DateButtons
  List<Widget> _weekdays(int weekIndex) {
    int _weekdayOffset() {
      // 0 = Monday, 1 = Tuesday...
      return now.weekday - 1;
    }

    List<Widget> weekdays = [];
    for (int i = _weekdayOffset() * (-1); i < 7 - _weekdayOffset(); i++) {
      weekdays.add(
          DateButton(dateTime: now.add(Duration(days: weekIndex * 7 + i))));
    }
    return weekdays;
  }
}

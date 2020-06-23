import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/HorizontalCalendar/DateButton.dart';

class DayScroller extends StatefulWidget {
  @override
  _DayScrollerState createState() => _DayScrollerState();
}

class _DayScrollerState extends State<DayScroller> {
  final controller = PageController(initialPage: 0);
  DateTime now = DateTime.now();
  DateTime _selectedDay;

  @override
  void initState() {
    _selectedDay = now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      height: 80,
      child: PageView.builder(
          controller: controller,
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
      DateTime date = now.add(Duration(days: weekIndex * 7 + i));
      weekdays.add(DateButton(
          dateTime: date,
          selectDay: (DateTime dateTime) {
            print(dateTime);
            setState(() {
              _selectedDay = dateTime;
            });
          },
          // No good compare
          isSelected: date.day == _selectedDay.day &&
              date.month == _selectedDay.month &&
              date.year == _selectedDay.year));
    }
    return weekdays;
  }
}

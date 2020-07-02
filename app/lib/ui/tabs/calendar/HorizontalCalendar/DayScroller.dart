import 'package:flutter/material.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/DateButton.dart';

class DayScroller extends StatefulWidget {
  DayScroller({Key key, @required this.selectedDay, @required this.selectDay})
      : super(key: key);

  final DateTime selectedDay;
  final Function(DateTime) selectDay;

  @override
  _DayScrollerState createState() => _DayScrollerState();
}

class _DayScrollerState extends State<DayScroller> {
  final controller = PageController(initialPage: 0);
  DateTime now = DateTime.now();

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
          selectDay: (DateTime dateTime) => widget.selectDay(dateTime),
          // No good compare
          isSelected: date.day == widget.selectedDay.day &&
              date.month == widget.selectedDay.month &&
              date.year == widget.selectedDay.year));
    }
    return weekdays;
  }
}

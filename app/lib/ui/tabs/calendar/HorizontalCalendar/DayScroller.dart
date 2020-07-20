import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/DateButton.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

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
  final DateTime now = DateTime.now();

  int _weeknumberNow;
  int _weeknumberInSwipe;

  _DayScrollerState() {
    // Weekday calculation from https://en.wikipedia.org/wiki/ISO_week_date#Calculation
    int dayOfYear =
        int.parse(DateFormat('D').format(now)); // day count from. 1. January
    _weeknumberNow = ((dayOfYear - now.weekday + 10) / 7).floor();
    _weeknumberInSwipe = _weeknumberNow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      height: 80,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            color: customColors.osloLightBlue,
            child: Text('Uke $_weeknumberInSwipe'),
          ),
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (int index) {
                setState(() {
                  _weeknumberInSwipe = _weeknumberNow + index;
                });
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, weekOffset) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _weekdays(weekOffset),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds a 5 day list of DateButtons
  List<Widget> _weekdays(int weekIndex) {
    int _weekdayOffset() {
      // 0 = Monday, 1 = Tuesday...
      return now.weekday - 1;
    }

    List<Widget> weekdays = [];
    for (int i = _weekdayOffset() * (-1); i < 5 - _weekdayOffset(); i++) {
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

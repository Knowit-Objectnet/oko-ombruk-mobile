import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/calendar/dialogs/EventInfoDialog.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';

class WeekCalendar extends StatefulWidget {
  WeekCalendar({Key key, @required this.dateTime, @required this.events})
      : super(key: key);

  final DateTime dateTime;
  final List<CalendarEvent> events;

  @override
  _WeekCalendarState createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  DateTime now = DateTime.now();
  DateTime dateNow;

  @override
  void initState() {
    dateNow = DateTime(now.year, now.month, now.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DayView(
      date: widget.dateTime,
      userZoomable: false,
      minimumTime: HourMinute(hour: 7),
      maximumTime: HourMinute(hour: 21),
      style: DayViewStyle(
        dayBarHeight: 0.0, // Hides dayBar hack
        backgroundColor: CustomColors.osloWhite,
        hourRowHeight: 55.0,
      ),
      events: widget.events
          .map((e) => FlutterWeekViewEvent(
              backgroundColor: CustomColors.partnerColor(e.partner?.name),
              textStyle: TextStyle(color: CustomColors.osloBlack),
              title: e.partner?.name ?? '',
              description: e.station?.name ?? '',
              start: e.startDateTime,
              end: e.endDateTime,
              onTap: () => showDialog(
                  context: context, builder: (_) => EventInfoDialog(event: e))))
          .toList(),
    );
  }
}

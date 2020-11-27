import 'package:flutter/material.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/calendar/dialogs/EventInfoDialog.dart';
import 'package:ombruk/ui/calendar/widgets/HorizontalCalendar/DayScroller.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/DayCalendarViewModel.dart';

class DayCalendar extends StatelessWidget {
  final List<CalendarEvent> events;
  final Station station;
  final Key key;
  final DateTime initialDate;
  final Function(DateTime) onDateChanged;
  DayCalendar({
    this.key,
    @required this.events,
    @required this.station,
    @required this.initialDate,
    @required this.onDateChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: DayCalendarViewModel(station, initialDate, onDateChanged),
      builder: (context, DayCalendarViewModel model, _) => Column(
        children: [
          DayScroller(
            selectedDate: model.selectedDate,
            onDateChanged: model.onDayChanged,
            station: station,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: CustomColors.osloBlack),
              children: <TextSpan>[
                TextSpan(
                  text: DateUtils.weekdaysLong[model.selectedDate.weekday],
                  style: TextStyle(fontSize: 16),
                ),
                TextSpan(
                  text: DateUtils.getDMYString(model.selectedDate),
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                DayView(
                  date: model.selectedDate,
                  userZoomable: false,
                  minimumTime: HourMinute(hour: model.opensAt.hour),
                  maximumTime: HourMinute(hour: model.closesAt.hour),
                  style: DayViewStyle(
                    dayBarHeight: 0.0, // Hides dayBar hack
                    backgroundColor: CustomColors.osloWhite,
                    hourRowHeight: 55.0,
                  ),
                  events: events
                      .map(
                        (e) => FlutterWeekViewEvent(
                          backgroundColor:
                              CustomColors.partnerColor(e.partner?.name),
                          textStyle: TextStyle(color: CustomColors.osloBlack),
                          title: e.partner?.name ?? '',
                          description: e.station?.name ?? '',
                          start: e.startDateTime,
                          end: e.endDateTime,
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => EventInfoDialog(event: e),
                          ),
                        ),
                      )
                      .toList(),
                ),
                if (model.isClosed)
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          CustomIcons.image(CustomIcons.calendar, size: 50.0),
                          Text(
                            'Vi er stengt!',
                            style: TextStyle(
                                fontSize: 28.0,
                                color: CustomColors.osloDarkBlue),
                          ),
                          Text(
                            'Vennligst velg en av dagene vi er åpne.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: CustomColors.osloDarkBlue),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

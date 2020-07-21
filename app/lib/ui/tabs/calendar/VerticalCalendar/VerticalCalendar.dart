import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ombruk/ui/tabs/SamPartnersComponents/CalendarEventExpander.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class VerticalCalendar extends StatefulWidget {
  VerticalCalendar({Key key, @required this.events}) : super(key: key);
  final List<CalendarEvent> events;

  @override
  _VerticalCalendarState createState() => _VerticalCalendarState();
}

class _VerticalCalendarState extends State<VerticalCalendar> {
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Groups the list on dates, with pretty text dividers
    return GroupedListView<CalendarEvent, DateTime>(
      elements: widget.events,
      groupBy: (CalendarEvent event) {
        // Sort without time
        DateTime date = event.startDateTime;
        DateTime sortDate = DateTime.utc(date.year, date.month, date.day);
        return sortDate;
      },
      groupSeparatorBuilder: (DateTime groupByValue) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: _dateText(groupByValue),
      ),
      indexedItemBuilder: (_, CalendarEvent event, index) {
        final bool isExpanded = _expandedIndex == index;
        return Container(
          color: customColors.partnerColor(event.partner?.name),
          child: ExpansionTile(
            initiallyExpanded: isExpanded,
            title: Row(
              children: <Widget>[
                _timeText(event.startDateTime, event.endDateTime),
                VerticalDivider(thickness: 100, color: customColors.osloBlack),
                Flexible(
                  child: Text(
                    event.partner?.name ?? '',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: customColors.osloBlack),
                  ),
                ),
              ],
            ),
            trailing: _trailingRow(isExpanded),
            onExpansionChanged: (bool newState) {
              setState(() {
                if (isExpanded) {
                  _expandedIndex = -1;
                } else {
                  _expandedIndex = index;
                }
              });
            },
            children: <Widget>[CalendarEventExpander(event: event)],
          ),
        );
      },
    );
  }

  Widget _trailingRow(bool expanded) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(expanded ? 'Mindre info' : 'Mer info',
            style: TextStyle(fontSize: 9.0)),
        expanded
            ? customIcons.image(customIcons.arrowUpThin)
            : customIcons.image(customIcons.arrowDownThin)
      ],
    );
  }

  Widget _timeText(DateTime start, DateTime end) {
    return Text(
        start.hour.toString().padLeft(2, '0') +
            ':' +
            start.minute.toString().padLeft(2, '0') +
            '-' +
            end.hour.toString().padLeft(2, '0') +
            ':' +
            end.minute.toString().padLeft(2, '0'),
        style: TextStyle(fontSize: 12.0, color: customColors.osloBlack));
  }

  Widget _dateText(DateTime dateTime) {
    return Text(
        globals.weekdaysLong[dateTime.weekday] +
            ' ' +
            dateTime.day.toString() +
            '. ' +
            globals.months[dateTime.month],
        style: TextStyle(fontWeight: FontWeight.bold));
  }
}

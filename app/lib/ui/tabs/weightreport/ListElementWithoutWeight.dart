import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/ui/tabs/weightreport/DateTimeBox.dart';
import 'package:ombruk/ui/tabs/weightreport/NameBox.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;

class ListElementWithoutWeight extends StatelessWidget {
  final CalendarEvent calendarEvent;
  final Function() onEditPress;

  ListElementWithoutWeight(this.calendarEvent, this.onEditPress)
      : assert(calendarEvent != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: DateTimeBox(
                        calendarEvent: calendarEvent, isReported: false),
                  ),
                  NameBox(
                    name: calendarEvent.partner?.name,
                    isReported: false,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: onEditPress,
                child: Container(
                  decoration: BoxDecoration(
                      color: customColors.osloWhite,
                      border:
                          Border.all(width: 2.0, color: customColors.osloRed)),
                  child: Center(
                    child: Text('Skriv inn vektuttak'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

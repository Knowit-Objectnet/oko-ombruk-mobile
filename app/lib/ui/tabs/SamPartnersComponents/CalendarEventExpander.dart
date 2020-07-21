import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/globals.dart' as globals;

class CalendarEventExpander extends StatelessWidget {
  CalendarEventExpander({Key key, @required this.event}) : super(key: key);

  final CalendarEvent event;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6),
        child: IntrinsicHeight(
            child: Container(
          //height: 350,
          color: customColors.osloWhite,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(children: <Widget>[
                  _dateTextDropDown(event.startDateTime),
                  _timeTextDropDown(event.startDateTime, event.endDateTime),
                  Row(
                    children: <Widget>[
                      customIcons.image(customIcons.map, size: 25),
                      VerticalDivider(thickness: 100),
                      Text(event.station.name.toString(),
                          style: TextStyle(fontSize: 18.0))
                    ],
                  )
                ]),
                Flexible(
                    child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Row(
                    children: <Widget>[
                      Text('Avlys uttak',
                          style: TextStyle(
                              color: customColors.osloBlack,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: customColors.osloRed,
                    radius: 20.0,
                    child: customIcons.image(customIcons.arrowDownThin),
                  ),
                  children: <Widget>[
                    Text('Her kommer det en slider!'),
                    FlatButton(
                        onPressed: () {
                          null;
                        },
                        child: Text('Bekreft'))
                  ],
                ))
              ],
            ),
          ),
        )));
  }

  Widget _timeTextDropDown(DateTime start, DateTime end) {
    return Row(
      children: <Widget>[
        customIcons.image(customIcons.clock, size: 25),
        VerticalDivider(thickness: 100),
        Text(
            start.hour.toString().padLeft(2, '0') +
                ':' +
                start.minute.toString().padLeft(2, '0') +
                ' til ' +
                end.hour.toString().padLeft(2, '0') +
                ':' +
                end.minute.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 18.0))
      ],
    );
  }

  Widget _dateTextDropDown(DateTime dateTime) {
    return Row(
      children: <Widget>[
        customIcons.image(customIcons.calendar, size: 25),
        VerticalDivider(thickness: 100),
        Text(
            globals.monthsShort[dateTime.month] +
                ' ' +
                dateTime.day.toString() +
                ', ' +
                dateTime.year.toString(),
            style: TextStyle(fontSize: 18.0))
      ],
    );
  }
}

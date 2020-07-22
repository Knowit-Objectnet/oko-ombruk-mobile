import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/components/DatePicker.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/globals.dart' as globals;

class CalendarEventExpander extends StatefulWidget {
  CalendarEventExpander({Key key, @required this.event}) : super(key: key);

  final CalendarEvent event;
  @override
  _CalendarEventExpanderState createState() => _CalendarEventExpanderState();
}

class _CalendarEventExpanderState extends State<CalendarEventExpander> {
  bool isExpanded = false;
  bool periode = false;
  DateTime endPeriode = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customColors.osloWhite,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              _dateTextDropDown(widget.event.startDateTime),
              SizedBox(
                height: 20,
              ),
              _timeTextDropDown(
                  widget.event.startDateTime, widget.event.endDateTime),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  customIcons.image(customIcons.map, size: 25),
                  VerticalDivider(thickness: 100),
                  Text(widget.event.station.name.toString(),
                      style: TextStyle(fontSize: 18.0))
                ],
              ),
              SizedBox(height: 15)
            ]),
            IntrinsicHeight(
                child: ExpansionTile(
              title: Text('Avlys uttak',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: customColors.osloBlack,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  )),
              trailing: CircleAvatar(
                backgroundColor: customColors.osloRed,
                radius: 20.0,
                child: isExpanded
                    ? customIcons.image(customIcons.arrowUpThin)
                    : customIcons.image(customIcons.arrowDownThin),
              ),
              onExpansionChanged: (bool newState) {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Transform.scale(
                            scale: 1.5,
                            child: Radio(
                                activeColor: customColors.osloBlack,
                                groupValue: periode,
                                value: false,
                                onChanged: (bool value) {
                                  setState(() {
                                    periode = value;
                                  });
                                })),
                        Text('Engangstilfelle')
                      ]),
                      Row(children: <Widget>[
                        Transform.scale(
                            scale: 1.5,
                            child: Radio(
                                activeColor: customColors.osloBlack,
                                groupValue: periode,
                                value: true,
                                onChanged: (bool value) {
                                  setState(() {
                                    periode = value;
                                  });
                                })),
                        Text('Periode')
                      ])
                    ]),
                SizedBox(height: 10),
                if (periode)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Sluttdato', style: TextStyle(fontSize: 16.0)),
                      DatePicker(
                        dateTime: endPeriode,
                        dateChanged: (value) {
                          setState(() {
                            endPeriode = value;
                          });
                        },
                      )
                    ],
                  ),
                SizedBox(height: 10),
                FlatButton(
                    onPressed: () {
                      null;
                    },
                    padding:
                        EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                    color: customColors.osloGreen,
                    child: Text('Bekreft',
                        style: TextStyle(fontWeight: FontWeight.bold)))
              ],
            ))
          ],
        ),
      ),
    );
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

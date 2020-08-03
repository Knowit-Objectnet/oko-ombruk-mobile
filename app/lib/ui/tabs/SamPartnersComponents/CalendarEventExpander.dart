import 'package:flutter/material.dart';

import 'package:ombruk/businessLogic/CalendarViewModel.dart';

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;

import 'package:ombruk/globals.dart' as globals;
import 'package:provider/provider.dart';

class CalendarEventExpander extends StatefulWidget {
  CalendarEventExpander({Key key, @required this.event}) : super(key: key);

  final CalendarEvent event;
  @override
  _CalendarEventExpanderState createState() => _CalendarEventExpanderState();
}

class _CalendarEventExpanderState extends State<CalendarEventExpander> {
  bool isExpanded = false;
  bool period = false;
  bool edit = false;
  DateTime endPeriod = DateTime.now();
  DateTime updatedDate = DateTime.now();
  TimeOfDay updatedStartTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay updatedEndTime = TimeOfDay(hour: 9, minute: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(
      builder: (context, CalendarViewModel calendarViewModel, child) {
        return Container(
          color: customColors.osloWhite,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Column(children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _dateTextDropDown(widget.event.startDateTime),
                        RawMaterialButton(
                            fillColor: customColors.osloLightBlue,
                            child: customIcons.image(customIcons.editIcon),
                            onPressed: () => {
                                  setState(() {
                                    edit = true;
                                    updatedDate = widget.event.startDateTime;
                                    updatedStartTime = TimeOfDay(
                                        hour: widget.event.startDateTime.hour,
                                        minute:
                                            widget.event.startDateTime.minute);
                                    updatedEndTime = TimeOfDay(
                                        hour: widget.event.endDateTime.hour,
                                        minute:
                                            widget.event.endDateTime.minute);
                                  })
                                },
                            shape: CircleBorder())
                      ]),
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
                    child: edit
                        ? ButtonBar(
                            children: <Widget>[
                              RawMaterialButton(
                                fillColor: customColors.osloRed,
                                child: customIcons.image(customIcons.close),
                                shape: CircleBorder(),
                                onPressed: () {
                                  setState(() {
                                    edit = false;
                                  });
                                },
                              ),
                              RawMaterialButton(
                                fillColor: customColors.osloGreen,
                                child: Icon(
                                  Icons.check, // TODO add proper icon
                                  color: customColors.osloBlack,
                                ),
                                shape: CircleBorder(),
                                onPressed: () => _updateEvent(
                                  widget.event.id,
                                  updatedDate,
                                  updatedStartTime,
                                  updatedEndTime,
                                  calendarViewModel,
                                ),
                              )
                            ],
                          )
                        : ExpansionTile(
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
                                  : customIcons
                                      .image(customIcons.arrowDownThin),
                            ),
                            onExpansionChanged: (bool newState) {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Transform.scale(
                                          scale: 1.5,
                                          child: Radio(
                                              activeColor:
                                                  customColors.osloBlack,
                                              groupValue: period,
                                              value: false,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  period = value;
                                                });
                                              })),
                                      Text('Engangstilfelle')
                                    ]),
                                    Row(children: <Widget>[
                                      Transform.scale(
                                          scale: 1.5,
                                          child: Radio(
                                              activeColor:
                                                  customColors.osloBlack,
                                              groupValue: period,
                                              value: true,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  period = value;
                                                  endPeriod =
                                                      widget.event.endDateTime;
                                                });
                                              })),
                                      Text('Periode')
                                    ])
                                  ]),
                              SizedBox(height: 10),
                              if (period)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Sluttdato',
                                        style: TextStyle(fontSize: 16.0)),
                                    DatePicker(
                                      dateTime: endPeriod,
                                      dateChanged: (value) {
                                        setState(() {
                                          endPeriod = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              SizedBox(height: 10),
                              FlatButton(
                                  onPressed: () {
                                    _deleteEvent(
                                      widget.event.id,
                                      widget.event.startDateTime,
                                      endPeriod,
                                      widget.event.recurrenceRule.id,
                                      calendarViewModel,
                                    );
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 120, vertical: 10),
                                  color: customColors.osloGreen,
                                  child: Text('Bekreft',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                            ],
                          ))
              ],
            ),
          ),
        );
      },
    );
  }

  void _updateEvent(
    int id,
    DateTime date,
    TimeOfDay startTime,
    TimeOfDay endTime,
    CalendarViewModel calendarViewModel,
  ) async {
    uiHelper.showLoading(context);
    final bool success =
        await calendarViewModel.updateEvent(id, date, startTime, endTime);
    uiHelper.hideLoading(context);

    if (success) {
      setState(() {
        edit = false;
      });
      uiHelper.showSnackbar(context, 'Hendelsen er oppdatert');
    } else {
      uiHelper.showSnackbar(context, 'Intern feil');
    }
  }

  void _deleteEvent(
    int id,
    DateTime startDate,
    DateTime endDate,
    dynamic recurrenceRuleId,
    CalendarViewModel calendarViewModel,
  ) async {
    period ? id = null : recurrenceRuleId = null;

    uiHelper.showLoading(context);
    final bool success = await calendarViewModel.deleteCalendarEvent(
        id, startDate, endDate, recurrenceRuleId);
    uiHelper.hideLoading(context);

    if (success) {
      uiHelper.showSnackbar(context, 'Slettet hendelse');
    } else {
      uiHelper.showSnackbar(context, 'Intern feil');
    }
  }

  Widget _timeTextDropDown(DateTime start, DateTime end) {
    return Row(
      children: <Widget>[
        customIcons.image(customIcons.clock, size: 25),
        VerticalDivider(thickness: 100),
        edit
            ? Flexible(
                child: Row(children: <Widget>[
                TimePicker(
                    selectedTime: updatedStartTime,
                    timeChanged: (value) {
                      setState(() {
                        updatedStartTime = value;
                      });
                    }),
                Text('  til  ', style: TextStyle(fontSize: 18.0)),
                TimePicker(
                    selectedTime: updatedEndTime,
                    timeChanged: (value) {
                      setState(() {
                        updatedEndTime = value;
                      });
                    })
              ]))
            : Text(
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
        edit
            ? DatePicker(
                dateTime: updatedDate,
                dateChanged: (value) {
                  setState(() {
                    updatedDate = value;
                  });
                })
            : Text(
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

import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/shared/widgets/DatePicker.dart';
import 'package:ombruk/ui/shared/widgets/TimePicker.dart';

import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/CalendarViewModel.dart';
import 'package:provider/provider.dart';

class CalendarEventExpander extends StatefulWidget {
  CalendarEventExpander({Key key, @required this.event}) : super(key: key);

  final CalendarEvent event;
  @override
  _CalendarEventExpanderState createState() => _CalendarEventExpanderState();
}

class _CalendarEventExpanderState extends State<CalendarEventExpander> {
  bool _isExpanded = false;
  bool _period = false;
  bool _edit = false;
  DateTime _endPeriod = DateTime.now();
  DateTime _updatedDate = DateTime.now();
  TimeOfDay _updatedStartTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _updatedEndTime = TimeOfDay(hour: 9, minute: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarViewModel>(
      builder: (context, CalendarViewModel calendarViewModel, child) {
        return Container(
          color: CustomColors.osloWhite,
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
                            fillColor: CustomColors.osloLightBlue,
                            child: CustomIcons.image(CustomIcons.editIcon),
                            onPressed: () => {
                                  setState(() {
                                    _edit = true;
                                    _updatedDate = widget.event.startDateTime;
                                    _updatedStartTime = TimeOfDay(
                                        hour: widget.event.startDateTime.hour,
                                        minute:
                                            widget.event.startDateTime.minute);
                                    _updatedEndTime = TimeOfDay(
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
                      CustomIcons.image(CustomIcons.map, size: 25),
                      VerticalDivider(thickness: 100),
                      Text(widget.event.station.name.toString(),
                          style: TextStyle(fontSize: 18.0))
                    ],
                  ),
                  SizedBox(height: 15)
                ]),
                IntrinsicHeight(
                    child: _edit
                        ? ButtonBar(
                            children: <Widget>[
                              RawMaterialButton(
                                fillColor: CustomColors.osloRed,
                                child: CustomIcons.image(CustomIcons.close),
                                shape: CircleBorder(),
                                onPressed: () {
                                  setState(() {
                                    _edit = false;
                                  });
                                },
                              ),
                              RawMaterialButton(
                                fillColor: CustomColors.osloGreen,
                                child: Icon(
                                  Icons.check, // TODO add proper icon
                                  color: CustomColors.osloBlack,
                                ),
                                shape: CircleBorder(),
                                onPressed: () => _updateEvent(
                                  widget.event.id,
                                  _updatedDate,
                                  _updatedStartTime,
                                  _updatedEndTime,
                                  calendarViewModel,
                                ),
                              )
                            ],
                          )
                        : ExpansionTile(
                            title: Text('Avlys uttak',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: CustomColors.osloBlack,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            trailing: CircleAvatar(
                              backgroundColor: CustomColors.osloRed,
                              radius: 20.0,
                              child: _isExpanded
                                  ? CustomIcons.image(CustomIcons.arrowUpThin)
                                  : CustomIcons.image(
                                      CustomIcons.arrowDownThin),
                            ),
                            onExpansionChanged: (bool newState) {
                              setState(() {
                                _isExpanded = !_isExpanded;
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
                                                  CustomColors.osloBlack,
                                              groupValue: _period,
                                              value: false,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _period = value;
                                                });
                                              })),
                                      Text('Engangstilfelle')
                                    ]),
                                    Row(children: <Widget>[
                                      Transform.scale(
                                          scale: 1.5,
                                          child: Radio(
                                              activeColor:
                                                  CustomColors.osloBlack,
                                              groupValue: _period,
                                              value: true,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  _period = value;
                                                  _endPeriod =
                                                      widget.event.endDateTime;
                                                });
                                              })),
                                      Text('Periode')
                                    ])
                                  ]),
                              SizedBox(height: 10),
                              if (_period)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Sluttdato',
                                        style: TextStyle(fontSize: 16.0)),
                                    DatePicker(
                                      dateTime: _endPeriod,
                                      dateChanged: (value) {
                                        setState(() {
                                          _endPeriod = value;
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
                                      _endPeriod,
                                      widget.event.recurrenceRule.id,
                                      calendarViewModel,
                                    );
                                  },
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 120, vertical: 10),
                                  color: CustomColors.osloGreen,
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

  Future<void> _updateEvent(
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
        _edit = false;
      });
      uiHelper.showSnackbar(context, 'Hendelsen er oppdatert');
    } else {
      uiHelper.showSnackbar(context, 'Intern feil');
    }
  }

  Future<void> _deleteEvent(
    int id,
    DateTime startDate,
    DateTime endDate,
    dynamic recurrenceRuleId,
    CalendarViewModel calendarViewModel,
  ) async {
    _period ? id = null : recurrenceRuleId = null;

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
        CustomIcons.image(CustomIcons.clock, size: 25),
        VerticalDivider(thickness: 100),
        _edit
            ? Flexible(
                child: Row(children: <Widget>[
                TimePicker(
                    selectedTime: _updatedStartTime,
                    timeChanged: (value) {
                      setState(() {
                        _updatedStartTime = value;
                      });
                    }),
                Text('  til  ', style: TextStyle(fontSize: 18.0)),
                TimePicker(
                    selectedTime: _updatedEndTime,
                    timeChanged: (value) {
                      setState(() {
                        _updatedEndTime = value;
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
        CustomIcons.image(CustomIcons.calendar, size: 25),
        VerticalDivider(thickness: 100),
        _edit
            ? DatePicker(
                dateTime: _updatedDate,
                dateChanged: (value) {
                  setState(() {
                    _updatedDate = value;
                  });
                })
            : Text(
                DateUtils.monthsShort[dateTime.month] +
                    ' ' +
                    dateTime.day.toString() +
                    ', ' +
                    dateTime.year.toString(),
                style: TextStyle(fontSize: 18.0))
      ],
    );
  }
}

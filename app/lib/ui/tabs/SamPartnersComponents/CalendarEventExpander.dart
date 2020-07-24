import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/ui/ui.helper.dart';

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
  bool edit = false;
  DateTime endPeriode = DateTime.now();
  DateTime updatedDate = DateTime.now();
  TimeOfDay updatedStartTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay updatedEndTime = TimeOfDay(hour: 9, minute: 0);

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
                                    minute: widget.event.startDateTime.minute);
                                updatedEndTime = TimeOfDay(
                                    hour: widget.event.endDateTime.hour,
                                    minute: widget.event.endDateTime.minute);
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
                              Icons.check,
                              color: customColors.osloBlack,
                            ),
                            shape: CircleBorder(),
                            //customIcons.image(customIcons.checkedCheckbox),
                            onPressed: () => _updateEvent(widget.event.id,
                                updatedDate, updatedStartTime, updatedEndTime),
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
                                Text('Sluttdato',
                                    style: TextStyle(fontSize: 16.0)),
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
                                _deleteEvent(
                                    widget.event.id,
                                    widget.event.startDateTime,
                                    endPeriode,
                                    widget.event.recurrenceRule.id);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 10),
                              color: customColors.osloGreen,
                              child: Text('Bekreft',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)))
                        ],
                      ))
          ],
        ),
      ),
    );
  }

  void _updateEvent(
      int id, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    print('id:' +
        id.toString() +
        ', date: ' +
        date.toString() +
        ', startTime: ' +
        startTime.toString() +
        ', endTime: ' +
        endTime.toString());
    try {
      bool updateSuccess =
          await CalendarApiClient().updateEvent(id, date, startTime, endTime);
      if (updateSuccess) {
        setState(() {
          edit = false;
        });
        BlocProvider.of<CalendarBloc>(context).add(CalendarRefreshRequested());
        uiHelper.showSnackbar(context, 'Hendelsen er oppdatert');
      } else {
        throw Exception();
      }
    } catch (e) {
      uiHelper.showSnackbar(context, 'Intern feil');
    } finally {
      uiHelper.hideLoading(context);
    }
  }

  void _deleteEvent(int id, DateTime startDate, DateTime endDate,
      dynamic recurrenceRuleId) async {
    periode ? id = null : recurrenceRuleId = null;
    try {
      bool deleteSuccess = await CalendarApiClient()
          .deleteCalendarEvent(id, startDate, endDate, recurrenceRuleId);
      if (deleteSuccess) {
        uiHelper.showSnackbar(context, 'Slettet hendelse');
        BlocProvider.of<CalendarBloc>(context).add(CalendarRefreshRequested());
      } else {
        throw Exception();
      }
    } catch (e) {
      uiHelper.showSnackbar(context, 'Intern feil');
    } finally {
      uiHelper.hideLoading(context);
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

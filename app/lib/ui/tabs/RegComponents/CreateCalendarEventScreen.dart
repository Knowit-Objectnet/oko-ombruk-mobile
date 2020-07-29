import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';

import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/PartnerPicker.dart';
import 'package:ombruk/ui/tabs/components/StationPicker.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';
import 'package:ombruk/ui/tabs/components/WeekdayPicker.dart';
import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';
import 'package:ombruk/ui/ui.helper.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class CreateCalendarEventScreen extends StatefulWidget {
  @override
  _CreateCalendarEventScreenState createState() =>
      _CreateCalendarEventScreenState();
}

class _CreateCalendarEventScreenState extends State<CreateCalendarEventScreen> {
  String _selectedStation;
  String _selectedPartner;
  List<globals.Weekdays> _selectedWeekdays = [];
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TextEditingController _merknadController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add gesture detector to take focus off textfield
    return Container(
      color: customColors.osloLightBeige,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          _textWithPadding('Opprett hendelse'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: StationPicker(
              selectedStation: _selectedStation,
              stationChanged: (value) {
                setState(() => {_selectedStation = value});
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: PartnerPicker(
              selectedPartner: _selectedPartner,
              partnerChanged: (value) {
                setState(() {
                  _selectedPartner = value;
                });
              },
            ),
          ),
          _textWithPadding('Velg ukedager'),
          WeekdayPicker(
            selectedWeekdays: _selectedWeekdays,
            weekdaysChanged: (value) {
              if (_selectedWeekdays.contains(value)) {
                setState(() {
                  _selectedWeekdays.remove(value);
                });
              } else {
                setState(() {
                  _selectedWeekdays.add(value);
                });
              }
            },
          ),
          _textWithPadding('Velg starttidspunkt'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              customIcons.image(customIcons.clock),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TimePicker(
                        selectedTime: _startTime,
                        timeChanged: (value) {
                          setState(() {
                            _startTime = value;
                          });
                        },
                      ),
                      Text('-'),
                      DatePicker(
                        dateTime: _startDate,
                        dateChanged: (value) {
                          setState(() {
                            _startDate = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _textWithPadding('Velg slutttidspunkt'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              customIcons.image(customIcons.clock),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TimePicker(
                        selectedTime: _endTime,
                        timeChanged: (value) {
                          setState(() {
                            _endTime = value;
                          });
                        },
                      ),
                      Text('-'),
                      DatePicker(
                        dateTime: _endDate,
                        dateChanged: (value) {
                          setState(() {
                            _endDate = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _textWithPadding('Alternativt'),
          Container(
            padding: EdgeInsets.only(left: 4.0),
            color: customColors.osloWhite,
            child: TextField(
              controller: _merknadController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '*Merknad',
              ),
              textCapitalization: TextCapitalization.sentences,
              autofocus: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: FlatButton(
              onPressed: _submitForm,
              color: customColors.osloLightGreen,
              child: Text('Opprett'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textWithPadding(String text) {
    return Padding(
        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ));
  }

  Future<void> _submitForm() async {
    CreateCalendarEventData eventData;
    try {
      eventData = CreateCalendarEventData.fromData(
          startDate: _startDate,
          endDate: _endDate,
          startTime: _startTime,
          endTime: _endTime,
          station: _selectedStation,
          partner: _selectedPartner,
          weekdays: _selectedWeekdays);
    } catch (e) {
      uiHelper.showSnackbar(
          context,
          e.toString().substring(
              11, e.toString().length)); // substring removes 'Exception: '
      return;
    }

    uiHelper.showLoading(context);
    try {
      bool creationSuccess =
          await CalendarApiClient().createCalendarEvent(eventData);
      if (creationSuccess) {
        uiHelper.showSnackbar(context, 'Opprettet hendelse');
        BlocProvider.of<CalendarBloc>(context).add(CalendarRefreshRequested());
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      uiHelper.showSnackbar(context, 'Intern feil');
    } finally {
      uiHelper.hideLoading(context);
    }
  }
}

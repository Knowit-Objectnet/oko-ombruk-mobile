import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/CalendarViewModel.dart';

import 'package:ombruk/globals.dart' as globals;

import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/ReturnButton.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';
import 'package:ombruk/ui/tabs/components/WeekdayPicker.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class CreateCalendarEventScreen extends StatefulWidget {
  final Station station;
  final Partner partner;

  CreateCalendarEventScreen({
    @required this.station,
    @required this.partner,
  })  : assert(station != null),
        assert(partner != null);

  @override
  _CreateCalendarEventScreenConsumedState createState() =>
      _CreateCalendarEventScreenConsumedState();
}

class _CreateCalendarEventScreenConsumedState
    extends State<CreateCalendarEventScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _interval;
  List<globals.Weekdays> _selectedWeekdays;
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TextEditingController _merknadController = TextEditingController();

  final Map<String, int> _intervalElements = {
    'Ukentlig': 1,
    'Annenhver uke': 2,
  };

  @override
  Widget build(BuildContext context) {
    // TODO: Add gesture detector to take focus off textfield

    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Container(
          color: customColors.osloLightBeige,
          // We create a new context so that the SnackBar knows where to pop up
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              ReturnButton(returnValue: false),
              Text(
                'Opprett hendelse',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Container(
                    color: customColors.osloWhite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton<int>(
                          value: _interval,
                          onChanged: (value) {
                            setState(() {
                              _interval = value;
                            });
                          },
                          underline: Container(),
                          items: _intervalElements.entries
                              .map((entry) => DropdownMenuItem(
                                    value: entry.value,
                                    child: Text(entry.key),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  )),
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
                padding: EdgeInsets.only(left: 8.0),
                color: customColors.osloWhite,
                child: TextField(
                  controller: _merknadController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Merknad',
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
        ),
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
    // CreateCalendarEventData eventData;
    // try {
    //   eventData = CreateCalendarEventData.fromData(
    //     startDate: _startDate,
    //     endDate: _endDate,
    //     startTime: _startTime,
    //     endTime: _endTime,
    //     station: widget.station,
    //     partner: widget.partner,
    //     weekdays: _selectedWeekdays,
    //     interval: _interval,
    //   );
    // } catch (e) {
    //   uiHelper.showSnackbarUnknownScaffold(
    //       _key.currentState,
    //       e.toString().substring(
    //           11, e.toString().length)); // substring removes 'Exception: '
    //   return;
    // }

    uiHelper.showLoading(context);
    final bool success =
        await Provider.of<CalendarViewModel>(context, listen: false)
            .createCalendarEvent(
                _startDate,
                _endDate,
                _startTime,
                _endTime,
                widget.station.id,
                widget.partner.id,
                _selectedWeekdays,
                _interval);
    uiHelper.hideLoading(context);
    if (success) {
      Navigator.pop(context, true);
    } else {
      uiHelper.showSnackbarUnknownScaffold(_key.currentState, 'Intern feil');
    }
  }
}

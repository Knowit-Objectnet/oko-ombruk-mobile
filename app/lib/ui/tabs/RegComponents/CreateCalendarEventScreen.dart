import 'package:flutter/material.dart';

import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/PartnerPicker.dart';
import 'package:ombruk/ui/tabs/components/StationPicker.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';
import 'package:ombruk/ui/tabs/components/WeekdayPicker.dart';

import 'package:ombruk/globals.dart' as globals;

class CreateCalendarEventScreen extends StatefulWidget {
  @override
  _CreateCalendarEventScreenState createState() =>
      _CreateCalendarEventScreenState();
}

class _CreateCalendarEventScreenState extends State<CreateCalendarEventScreen> {
  String _selectedStation;
  String _selectedPartner;
  List<globals.Weekdays> _selectedWeekdays = [];
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TextEditingController _merknadController = TextEditingController();

  @override
  void initState() {
    _endTime = TimeOfDay(hour: _startTime.hour + 1, minute: _startTime.minute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: globals.osloLightBeige,
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
          _textWithPadding('Velg tidspunkt for uttak'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/icons/klokke.png', height: 20, width: 20),
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
                      TimePicker(
                        selectedTime: _endTime,
                        timeChanged: (value) {
                          setState(() {
                            _endTime = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          _textWithPadding('Velg periode'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/icons/kalender.png', height: 20, width: 20),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DatePicker(
                        dateTime: _startDate,
                        dateChanged: (value) {
                          setState(() {
                            _startDate = value;
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
            color: globals.osloWhite,
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
              color: globals.osloLightGreen,
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
    // TODO
    print('submit');
  }
}

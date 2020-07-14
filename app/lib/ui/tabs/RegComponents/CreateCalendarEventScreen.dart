import 'package:flutter/material.dart';
import 'package:ombruk/ui/tabs/components/PartnerPicker.dart';
import 'package:ombruk/ui/tabs/components/StationPickerDropdownButton.dart';
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/tabs/components/TimePicker.dart';
import 'package:ombruk/ui/tabs/components/WeekdayPicker.dart';

class CreateCalendarEventScreen extends StatefulWidget {
  @override
  _CreateCalendarEventScreenState createState() =>
      _CreateCalendarEventScreenState();
}

class _CreateCalendarEventScreenState extends State<CreateCalendarEventScreen> {
  String _selectedStation = globals.stations[0];
  String _selectedPartner = globals.partners[0];
  List<globals.Weekdays> _selectedWeekdays = [];
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime;

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
          StationPickerDropdownButton(
            selectedStation: _selectedStation,
            stationChanged: (value) {
              setState(() => {_selectedStation = value});
            },
          ),
          PartnerPicker(
            selectedPartner: _selectedPartner,
            partnerChanged: (value) {
              setState(() {
                _selectedPartner = value;
              });
            },
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/icons/klokke.png', height: 20, width: 20),
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
          _textWithPadding('Velg periode'),
          // TODO:
          // Add date pickers here
          // TextInput here
          // Button here
        ],
      ),
    );
  }

  Widget _textWithPadding(String text) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ));
  }
}

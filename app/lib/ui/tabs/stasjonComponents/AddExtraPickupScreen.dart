import 'package:flutter/material.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/Station.dart';
import 'package:ombruk/businessLogic/PickupViewModel.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/ReturnButton.dart';
import 'package:ombruk/ui/tabs/components/StationPicker.dart';
import 'package:ombruk/ui/tabs/components/TextFormInput.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';

class AddExtraPickupScreen extends StatefulWidget {
  @override
  _AddExtraPickupScreenState createState() => _AddExtraPickupScreenState();
}

class _AddExtraPickupScreenState extends State<AddExtraPickupScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final TextEditingController _merknadControler = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  Station _selectedStation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: customColors.osloLightBeige,
        body: GestureDetector(
          /// .unfocus() fixes a problem where the TextFormField isn't unfocused
          /// when the user taps outside the TextFormField.
          onTap: () => FocusScope.of(context).unfocus(),
          onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              ReturnButton(returnValue: false),
              Text(
                'Utlys ekstrauttak',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _subtitle('Velg dato for uttak'),
              _dateRow(),
              _subtitle('Velg tidspunkt'),
              _timePickersRow(),
              _subtitle('Stasjon (hvem er du?)'),
              // This picker is to be removed. It is only temporary because we
              // cannot get which station we are logged in as from backend yet.
              StationPicker(
                selectedStation: _selectedStation,
                stationChanged: (value) {
                  setState(() {
                    _selectedStation = value;
                  });
                },
              ),
              _subtitle('Alternativt'),
              TextFormInput(
                hint: 'Merknad (max 100 tegn)',
                controller: _merknadControler,
                maxLength: 100,
                validate: false,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: _submit,
                  color: customColors.osloGreen,
                  child: Text('Send'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _subtitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
      child: Text(
        text ?? '',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _dateRow() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: customIcons.image(customIcons.calendar),
        ),
        Expanded(
          child: DatePicker(
            dateTime: _selectedDate,
            dateChanged: (value) {
              setState(() {
                _selectedDate = value;
              });
            },
            borderColor: null,
          ),
        )
      ],
    );
  }

  Widget _timePickersRow() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: customIcons.image(customIcons.clock),
        ),
        Expanded(
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
        )
      ],
    );
  }

  Future<void> _submit() async {
    // TODO: Make the timecheck a globally available function
    if (_startTime.hour > _endTime.hour) {
      uiHelper.showSnackbarUnknownScaffold(
          _key.currentState, 'Start tid kan ikke være før slutt tid');
      return;
    }
    if (_startTime.hour == _endTime.hour &&
        _startTime.minute >= _endTime.minute) {
      uiHelper.showSnackbarUnknownScaffold(
          _key.currentState, 'Start tid kan ikke være før eller lik slutt tid');
      return;
    }

    if (_selectedStation == null) {
      uiHelper.showSnackbarUnknownScaffold(
          _key.currentState, 'Vennligst velg en stasjon');
      return;
    }

    final DateTime startDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _startTime.hour,
      _startTime.minute,
    );

    final DateTime endDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    final bool success =
        await Provider.of<PickupViewModel>(context, listen: false).addPickup(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      description: _merknadControler.text,
      stationId: _selectedStation.id,
    );

    if (success) {
      Navigator.pop(context, true);
    } else {
      uiHelper.showSnackbarUnknownScaffold(_key.currentState, 'Intern feil');
    }
  }
}

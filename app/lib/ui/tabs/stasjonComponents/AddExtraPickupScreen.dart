import 'package:flutter/material.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/tabs/components/DatePicker.dart';
import 'package:ombruk/ui/tabs/components/PartnerPicker.dart';
import 'package:ombruk/ui/tabs/components/ReturnButton.dart';
import 'package:ombruk/ui/tabs/components/TextFormInput.dart';
import 'package:ombruk/ui/tabs/components/TimePicker.dart';

class AddExtraPickupScreen extends StatefulWidget {
  @override
  _AddExtraPickupScreenState createState() => _AddExtraPickupScreenState();
}

class _AddExtraPickupScreenState extends State<AddExtraPickupScreen> {
  final TextEditingController _merknadControler = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  String _selectedPartner;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: customColors.osloLightBeige,
        body: GestureDetector(
          /// .unfocus() fixes a problem where the TextFormField isn't unfocused
          /// when the user taps outside the TextFormField.
          onTap: () => FocusScope.of(context).unfocus(),
          onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              ReturnButton(),
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
              _subtitle('Sam. partner'),
              PartnerPicker(
                selectedPartner: _selectedPartner,
                partnerChanged: (value) {
                  setState(() {
                    _selectedPartner = value;
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
    // TODO
    return;
  }
}

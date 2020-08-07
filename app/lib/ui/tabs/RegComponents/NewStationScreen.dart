import 'package:flutter/material.dart';
import 'package:ombruk/ui/tabs/components/ReturnButton.dart';
import 'package:ombruk/ui/tabs/components/ReturnButtonTitle.dart';

import 'package:ombruk/ui/tabs/components/TimePicker.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/globals.dart' as globals;

class NewStationScreen extends StatefulWidget {
  @override
  _NewStationScreenState createState() => _NewStationScreenState();
}

class _NewStationScreenState extends State<NewStationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _stationNameController = TextEditingController();
  final TextEditingController _stationAddressController =
      TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _verticalPadding = EdgeInsets.symmetric(vertical: 8.0);

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
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                ReturnButton(),
                ReturnButtonTitle('Legg til ny stasjon'),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: _textInput('Navn på stasjon', _stationNameController),
                ),
                Padding(
                  padding: _verticalPadding,
                  child: _textInput(
                      'Adresse til stasjonen', _stationAddressController),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _textWithPadding('Åpningstid'),
                    Text('Stengt'),
                  ],
                ),
                _timeRows(),
                _textWithPadding('Kontaktinformasjon til ombruksamdassadør'),
                _textInputWithIcon('Navn', _nameController, customIcons.person),
                _textInputWithIcon(
                    'Telefornummer', _phoneController, customIcons.mobile),
                _textInputWithIcon(
                    'Mail addresse', _emailController, customIcons.mail),
                Padding(
                  padding: _verticalPadding,
                  child: RaisedButton(
                    onPressed: _submitForm,
                    color: customColors.osloGreen,
                    child: Text('Legg til stasjon'),
                  ),
                ),
              ],
            ),
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
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ));
  }

  Widget _textInput(
    String hint,
    TextEditingController controller, {
    Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 4.0),
      decoration: BoxDecoration(
          color: customColors.osloWhite,
          border: borderColor != null
              ? Border.all(width: 2.0, color: borderColor)
              : null),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Vennligst fyll ut feltet';
          }
          return null;
        },
      ),
    );
  }

  Widget _textInputWithIcon(
      String hint, TextEditingController controller, String icon) {
    return Padding(
      padding: _verticalPadding,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: customIcons.image(icon),
          ),
          Expanded(
            child: _textInput(
              hint,
              controller,
              borderColor: customColors.osloBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeRows() {
    return Column(
      children: globals.weekdaysShort.values
          .map((weekday) => _TimePickersRow(
                weekday: weekday,
              ))
          .toList(),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      // TODO
      return;
    }
  }
}

class _TimePickersRow extends StatefulWidget {
  final String weekday;

  _TimePickersRow({@required this.weekday});

  @override
  _TimePickersRowState createState() => _TimePickersRowState();
}

class _TimePickersRowState extends State<_TimePickersRow> {
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 21, minute: 0);
  bool _isClosed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        // The SizedBox is used because the weekday strings have different
        // width, so the row elmeents becomes unevenly positioned without it.
        // Beware it may not be responsive, for example, if you change font size.
        SizedBox(
          width: 30.0,
          child: Text(widget.weekday ?? ''),
        ),
        _isClosed
            ? Container()
            : TimePicker(
                selectedTime: _startTime,
                timeChanged: (value) {
                  setState(() {
                    _startTime = value;
                  });
                },
                minTime: 6,
                maxTime: 24,
              ),
        _isClosed ? Container() : Text('-'),
        _isClosed
            ? Container()
            : TimePicker(
                selectedTime: _endTime,
                timeChanged: (value) {
                  setState(() {
                    _endTime = value;
                  });
                },
                minTime: 6,
                maxTime: 24,
              ),
        Checkbox(
          value: _isClosed,
          onChanged: (value) {
            setState(() {
              _isClosed = value;
            });
          },
        )
      ],
    );
  }
}

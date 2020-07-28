import 'package:flutter/material.dart';

import 'package:ombruk/ui/tabs/ExtraHentingPopup/DateField.dart';
import 'package:ombruk/ui/tabs/ExtraHentingPopup/TimeField.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

///! This components is deprecated
class ExtraHentingDialog extends StatefulWidget {
  @override
  _ExtraHentingDialogState createState() => _ExtraHentingDialogState();
}

class _ExtraHentingDialogState extends State<ExtraHentingDialog> {
  final whoController = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  TimeOfDay _selectedDur;
  String _selectedStation = globals.stations[0];

  @override
  void initState() {
    setState(() {
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
      _selectedDur = TimeOfDay.now();
    });
    super.initState();
  }

  @override
  void dispose() {
    whoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Søk om ekstra henting',
                      style: TextStyle(fontSize: 20.0))),
              IconButton(
                  icon: Image.asset('assets/icons/lukk.png',
                      height: 25, width: 25),
                  onPressed: _closeDialog)
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: customColors.osloBlack,
                thickness: 1,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TODO: Replace with the DatePicker component
              GestureDetector(
                child: DateField(
                  date: _selectedDate,
                ),
                onTap: () => _selectDate(context),
              ),
              Image.asset('assets/icons/klokke.png', height: 20, width: 20),
              // TODO: Replace with the TimePicker component
              GestureDetector(
                child: TimeField(
                  time: _selectedTime,
                ),
                onTap: () => _selectTime(context),
              ),
              Text(" - "),
              GestureDetector(
                child: TimeField(
                  time: _selectedDur,
                ),
                onTap: () => _selectDur(context),
              )
            ],
          ),
          Row(
            // TODO: Use the component StationPickerDropdownButton instead of Row here
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/icons/kart.png', height: 20, width: 20),
              Container(
                // color: , // TODO
                child: DropdownButton<String>(
                  value: _selectedStation,
                  onChanged: (value) {
                    setState(() {
                      _selectedStation = value;
                    });
                  },
                  underline: Container(),
                  items: globals.stations
                      .map((station) => DropdownMenuItem(
                            value: station,
                            child: Text(station),
                          ))
                      .toList(),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text('Hvem skal hente?'),
              ),
              Flexible(
                  flex: 1,
                  child: TextField(
                      controller: whoController,
                      decoration:
                          InputDecoration(hintText: 'Hvem skal hente?'))),
            ],
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                  onPressed: _closeDialog,
                  color: customColors.osloRed,
                  child: Text('Avbryt')),
              FlatButton(
                  onPressed: _submitDialog,
                  color: customColors.osloGreen,
                  child: Text('Søk'))
            ],
          )
        ],
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  Future<Null> _selectDur(BuildContext context) async {
    final TimeOfDay pickedDur = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (pickedDur != null && pickedDur != _selectedDur)
      setState(() {
        _selectedDur = pickedDur;
      });
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _submitDialog() {
    print("Submit");
  }
}

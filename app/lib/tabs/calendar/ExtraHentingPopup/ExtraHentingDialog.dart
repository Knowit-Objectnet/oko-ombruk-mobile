import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/ExtraHentingPopup/DateField.dart';
import 'package:ombruk/tabs/calendar/ExtraHentingPopup/TimeField.dart';

class ExtraHentingDialog extends StatefulWidget {
  @override
  _ExtraHentingDialogState createState() => _ExtraHentingDialogState();
}

class _ExtraHentingDialogState extends State<ExtraHentingDialog> {
  final whoController = TextEditingController();
  final whatController = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

          @override
  void initState() {
    setState(() {
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
    super.initState();
  }

  @override
  void dispose() {
    whoController.dispose();
    whatController.dispose();
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
              IconButton(icon: Icon(Icons.close), onPressed: _closeDialog)
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              )),
          GestureDetector(
            child: DateField(
              date: _selectedDate,
            ),
            onTap: () => _selectDate(context),
          ),
          GestureDetector(
            child: TimeField(
              time: _selectedTime,
            ),
            onTap: () => _selectTime(context),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text('Hva skal hentes?'),
              ),
              Flexible(
                  flex: 1,
                  child: TextField(
                      controller: whatController,
                      decoration:
                          InputDecoration(hintText: 'Hva skal hentes?'))),
            ],
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                  onPressed: _closeDialog,
                  color: Colors.red,
                  child: Text('Avbryt')),
              FlatButton(
                  onPressed: _submitDialog,
                  color: Colors.green,
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
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _submitDialog() {
    print("Submit");
  }
}

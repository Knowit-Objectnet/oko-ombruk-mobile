import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/DatePicker.dart';
import 'package:ombruk/ui/shared/widgets/PartnerPicker.dart';
import 'package:ombruk/ui/shared/widgets/StationPicker.dart';
import 'package:ombruk/ui/shared/widgets/TimePicker.dart';

class MessageView extends StatefulWidget {
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  Partner _selectedPartner;
  Station _selectedStation;
  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        /// .unfocus() fixes a problem where the TextFormField isn't unfocused
        /// when the user taps outside the TextFormField.
        onTap: () => FocusScope.of(context).unfocus(),
        onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
        child: Container(
          color: CustomColors.osloLightBeige,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                _subtitle('Send beskjed'),
                _subtitle('Emne'),
                Container(
                  padding: EdgeInsets.only(left: 4.0),
                  color: CustomColors.osloWhite,
                  child: TextFormField(
                    controller: _emneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Emne',
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Vennligst fyll ut et emne';
                      }
                      return null;
                    },
                  ),
                ),
                _subtitle('Mottaker(e)'),
                Text('Sam.partnere'),
                PartnerPicker(
                    selectedPartner: _selectedPartner,
                    partnerChanged: (value) {
                      setState(() {
                        _selectedPartner = value;
                      });
                    }),
                Text('Stasjoner'),
                StationPicker(
                  selectedStation: _selectedStation,
                  stationChanged: (value) {
                    setState(() {
                      _selectedStation = value;
                    });
                  },
                ),
                _subtitle('Velg starttidspunkt'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CustomIcons.image(CustomIcons.clock),
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
                _subtitle('Velg slutttidspunkt'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CustomIcons.image(CustomIcons.clock),
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
                _subtitle('Melding'),
                Container(
                  padding: EdgeInsets.only(left: 4.0),
                  color: CustomColors.osloWhite,
                  child: TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Meldingstekst (maks 200 tegn)',
                    ),
                    maxLength: 200,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Vennligst oppgi en melding';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: FlatButton(
                    onPressed: _submitForm,
                    color: CustomColors.osloLightGreen,
                    child: Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _subtitle(String text) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ));
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      // TODO
      return;
    }
  }
}

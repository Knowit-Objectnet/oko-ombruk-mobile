import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:ombruk/models/WeightEvent.dart';
import 'package:ombruk/ui/tabs/weightreport/DateTimeBox.dart';

class WeightReportScreen extends StatefulWidget {
  WeightReportScreen({Key key}) : super(key: key);
  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  List<WeightEvent> _weights = [];

  @override
  void initState() {
    // TODO: remove later
    _loadString().then((value) {
      setState(() {
        _weights = _parse(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9C66B),
        body: _weights.isEmpty
            ? Center(child: Text("Du har ingen uttak"))
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: _buildListWithSeperators(),
              ));
  }

  List<Widget> _buildListWithSeperators() {
    Widget _textDivider(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(text,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0)),
      );
    }

    List<Widget> list = [];
    list.add(_textDivider('Siste uttak'));
    for (int index = 0; index < _weights.length; index++) {
      if (index == 1) {
        list.add(_textDivider('Tidligere uttak'));
      }
      list.add(_weightElement(_weights[index]));
    }
    return list;
  }

  Widget _weightElement(WeightEvent weightEvent) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DateTimeBox(weightEvent: weightEvent),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  color: Colors.white,
                  child: weightEvent.weight != null
                      ? Text(weightEvent.weight.toString())
                      : TextField(
                          decoration: InputDecoration(hintText: 'Vekt i kg...'),
                          style: TextStyle(fontSize: 12.0),
                          keyboardType: TextInputType
                              .number, // Decimal not allowed right now, may fix later
                          inputFormatters: [
                            // WhitelistingTextInputFormatter(
                            // RegExp(r"^\d+\.?\d*$"))
                            // ],
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                        ),
                ),
              ),
              weightEvent.weight != null
                  ? Container()
                  : RawMaterialButton(
                      fillColor: Color(0xFFFF8274),
                      child: Text('OK'),
                      onPressed: _submit,
                      shape: CircleBorder()),
            ],
          ),
        ));
  }

  // TODO: Put this parser in data provider -> Bloc
  List<WeightEvent> _parse(dynamic response) {
    if (response == null) {
      return [];
    }
    String reponseString = response.toString();
    final Map<String, dynamic> parsed = jsonDecode(reponseString);
    if (parsed == null) {
      return [];
    }
    List<dynamic> events = parsed['events'];
    return events
        .map<WeightEvent>((json) => WeightEvent.fromJson(json))
        .toList();
  }

  // TODO: Remove this
  Future<String> _loadString() async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value('''{
      "events": [
        {
          "title": "Fretex",
          "description": "Beskrivelse",
          "start": "1969-07-20 18:18:04Z",
          "end": "1969-07-20 19:18:04Z",
          "weight": null
        },
        {
          "title": "Fretex",
          "description": "heihei",
          "start": "1969-07-20 20:18:04Z",
          "end": "1969-07-20 20:18:04Z",
          "weight": 3.0
        },
        {
          "title": "Fretex",
          "description": "Beskrivelse",
          "start": "1969-07-20 17:18:04Z",
          "end": "1969-07-20 21:18:04Z",
          "weight": null
        },
        {
          "title": "Maria",
          "description": "heihei",
          "start": "1969-07-20 20:18:04Z",
          "end": "1969-07-20 20:18:04Z",
          "weight": 0.0
        }
      ]
    }''');
  }

  void _submit() {}
}

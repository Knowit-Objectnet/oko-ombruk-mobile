import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ombruk/models/WeightEvent.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ombruk/ui/tabs/weightreport/RenameMe.dart';

List<WeightEvent> events = [
  WeightEvent(
      "Fretex",
      "beskrivelse",
      DateTime.now().subtract(Duration(hours: 5)),
      DateTime.now().subtract(Duration(hours: 1)),
      6),
  WeightEvent(
      "Ny dag",
      "Beskrivelse av opplegget",
      DateTime.now().add(Duration(days: 1)),
      DateTime.now().add(Duration(days: 1, hours: 1)),
      0),
];

class WeightReportScreen extends StatefulWidget {
  WeightReportScreen({Key key}) : super(key: key);
  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF9C66B),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Siste uttak',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFFF8274),
                              ),
                              child: Text(events[0].start.toString()),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 25),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Vektuttak (kg)',
                                      ),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        BlacklistingTextInputFormatter(
                                            new RegExp('[\\-|\\ ]'))
                                      ],
                                    ),
                                  ))),
                          RawMaterialButton(
                              fillColor: Color(0xFFFF8274),
                              child: Text('OK'),
                              onPressed: _submit,
                              shape: CircleBorder()),
                        ]),
                    flex: 1,
                  ),
                  Text('Tidligere uttak',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  Expanded(
                      child: FutureBuilder(
                          future: _loadString(),
                          builder: (context, snapshot) {
                            return EventList(events: _parse(snapshot.data));
                          }),
                      flex: 3),
                ])));
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
  Future<String> _loadString() {
    Future.delayed(Duration(seconds: 2));
    return Future.value('''{
      "events": [
        {
          "title": "Fretex",
          "description": "Beskrivelse",
          "start": "1969-07-20 18:18:04Z",
          "end": "1969-07-20 19:18:04Z",
          "weight": 2.0
        },
        {
          "title": "Fretex",
          "description": "heihei",
          "start": "1969-07-20 20:18:04Z",
          "end": "1969-07-20 20:18:04Z",
          "weight": 3.0
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

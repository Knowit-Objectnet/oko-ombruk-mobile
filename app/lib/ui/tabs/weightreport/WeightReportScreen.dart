import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/models/WeightEvent.dart';
import 'package:ombruk/ui/tabs/weightreport/DateTimeBox.dart';

class WeightReportScreen extends StatefulWidget {
  final List<WeightEvent> weightEvents;

  WeightReportScreen({Key key, @required this.weightEvents}) : super(key: key);

  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: customColors.osloYellow,
        body: widget.weightEvents.isEmpty
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
    for (int index = 0; index < widget.weightEvents.length; index++) {
      if (index == 1) {
        list.add(_textDivider('Tidligere uttak'));
      }
      list.add(_weightElement(widget.weightEvents[index]));
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
                  color: customColors.osloWhite,
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
                      fillColor: customColors.osloRed,
                      child: Text('OK'),
                      onPressed: () => null,
                      shape: CircleBorder()),
            ],
          ),
        ));
  }
}

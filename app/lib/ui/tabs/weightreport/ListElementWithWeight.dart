import 'package:flutter/material.dart';

import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/ui/tabs/weightreport/DateTimeBox.dart';
import 'package:ombruk/ui/tabs/weightreport/NameBox.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;

class ListElementWithWeight extends StatelessWidget {
  final WeightReport weightReport;
  final Function() onEditPress;

  final TextEditingController _inputController = TextEditingController();

  ListElementWithWeight(this.weightReport, this.onEditPress)
      : assert(weightReport != null) {
    _inputController.text = weightReport?.weight?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: DateTimeBox(
                        weightReport: weightReport, isReported: true),
                  ),
                  NameBox(name: weightReport.station?.name, isReported: true),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  color: customColors.osloLightBeige,
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      weightReport?.weight != null
                          ? Text(
                              weightReport.weight.toString() + ' kg',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : Text(''),
                      Spacer(),
                      GestureDetector(
                        onTap: onEditPress,
                        child: customIcons.image(customIcons.editIcon),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

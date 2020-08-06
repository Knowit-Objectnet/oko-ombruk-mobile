import 'package:flutter/material.dart';

import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/ui/tabs/weightreport/DateTimeBox.dart';
import 'package:ombruk/ui/tabs/weightreport/NameBox.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;

class ListElementWithoutWeight extends StatelessWidget {
  final WeightReport weightReport;
  final Function() onEditPress;

  ListElementWithoutWeight(this.weightReport, this.onEditPress)
      : assert(weightReport != null);

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
                children: <Widget>[
                  Expanded(
                    child: DateTimeBox(
                      weightReport: weightReport,
                      isReported: false,
                    ),
                  ),
                  NameBox(
                    name: weightReport.station?.name,
                    isReported: false,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onTap: onEditPress,
                child: Container(
                  decoration: BoxDecoration(
                      color: customColors.osloWhite,
                      border:
                          Border.all(width: 2.0, color: customColors.osloRed)),
                  child: Center(
                    child: Text('Skriv inn vektuttak'),
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

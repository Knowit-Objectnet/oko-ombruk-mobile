import 'package:flutter/material.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/weightreport/widgets/WeightReportListElement.dart';

class ReportWithoutWeight extends StatelessWidget {
  final WeightReport weightReport;
  final Function() onPressedCallback;
  ReportWithoutWeight({
    @required this.weightReport,
    @required this.onPressedCallback,
  });
  @override
  Widget build(BuildContext context) {
    return WeightReportListElement(
      weightReport: weightReport,
      child: GestureDetector(
        onTap: onPressedCallback,
        child: Container(
          decoration: BoxDecoration(
              color: CustomColors.osloWhite,
              border: Border.all(width: 2.0, color: CustomColors.osloRed)),
          child: Center(
            child: Text('Skriv inn vektuttak'),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/weightreport/widgets/WeightReportListElement.dart';

class ReportWithWeight extends StatelessWidget {
  final WeightReport report;
  final Function onTap;
  ReportWithWeight({
    @required this.report,
    @required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return WeightReportListElement(
      weightReport: report,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: double.infinity,
          color: CustomColors.osloLightBeige,
          child: Row(
            children: [
              Spacer(),
              Text(
                "${report.weight.toString()} kg",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Align(
                alignment: Alignment.topRight,
                child: CustomIcons.image(CustomIcons.editIcon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

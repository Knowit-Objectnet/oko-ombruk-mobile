import 'package:flutter/material.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/weightreport/widgets/DateTimeBox.dart';

class WeightReportListElement extends StatelessWidget {
  final WeightReport weightReport;
  final Widget child;
  WeightReportListElement({
    @required this.weightReport,
    this.child = const SizedBox(),
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  Expanded(
                    child: DateTimeBox(
                      weightReport: weightReport,
                      isReported: weightReport.weight != null,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        color: weightReport.weight != null
                            ? CustomColors.osloGreen
                            : CustomColors.osloRed,
                        child: Center(
                          child: (Text(weightReport.station?.name ?? '')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

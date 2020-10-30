import 'package:flutter/material.dart';
import 'package:ombruk/ui/app/widgets/AppDrawer.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/ui/weightreport/dialog/WeightReportDialog.dart';
import 'package:ombruk/ui/weightreport/widgets/ReportWithWeight.dart';
import 'package:ombruk/ui/weightreport/widgets/ReportWithoutWeight.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/viewmodel/WeightReportViewModel.dart';
import 'package:provider/provider.dart';

class WeightReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: WeightReportViewModel(Provider.of(context), Provider.of(context),
          Provider.of(context), Provider.of(context), Provider.of(context)),
      onModelReady: (WeightReportViewModel model) => model.fetchWeightReports(),
      builder: (context, WeightReportViewModel model, _) => Scaffold(
        appBar: OkoAppBar(
          title: "Vekt",
          showBackButton: false,
        ),
        drawer: AppDrawer(),
        body: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : RefreshIndicator(
                onRefresh: () async => await model.fetchWeightReports(),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Vektuttak",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Subtitle(text: "Ikke rapportert"),
                          if (model.nonReportedList.isNotEmpty)
                            ...model.nonReportedList.map((report) {
                              return ReportWithoutWeight(
                                weightReport: report,
                                onPressedCallback: () => model.onDialog(
                                  WeightReportDialog(
                                    onSubmit: (newWeight) =>
                                        model.addWeight(report, newWeight),
                                  ),
                                ),
                              );
                            }).toList(),
                          Subtitle(text: 'Tidligere uttak'),
                          if (model.reportedList.isNotEmpty)
                            ...model.reportedList
                                .map(
                                  (report) => ReportWithWeight(
                                    report: report,
                                    onTap: () => model.onDialog(
                                      WeightReportDialog(
                                        onSubmit: (newWeight) => model
                                            .updateWeight(report, newWeight),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

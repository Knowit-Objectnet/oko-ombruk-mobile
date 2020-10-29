import 'package:flutter/material.dart';
import 'package:ombruk/models/WeightReport.dart';
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
                                onPressedCallback: () => _showNewWeightDialog(
                                    context, model, report),
                              );
                            }).toList(),
                          Subtitle(text: 'Tidligere uttak'),
                          if (model.reportedList.isNotEmpty)
                            ...model.reportedList
                                .map((report) => ReportWithWeight(
                                      report: report,
                                      onTap: () => _showWeightEditDialog(
                                        context,
                                        model,
                                        report,
                                      ),
                                    ))
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

  Future<void> _showWeightEditDialog(
    BuildContext context,
    WeightReportViewModel model,
    WeightReport report,
  ) async {
    showDialog(
        context: context,
        builder: (_) {
          return WeightReportDialog(
              onSubmit: (newWeight) => model.updateWeight(report, newWeight));
        });
  }

  Future<void> _showNewWeightDialog(
    BuildContext context,
    WeightReportViewModel model,
    WeightReport report,
  ) async {
    showDialog(
        context: context,
        builder: (_) {
          return WeightReportDialog(
              onSubmit: (newWeight) => model.addWeight(report, newWeight));
        });
  }
}

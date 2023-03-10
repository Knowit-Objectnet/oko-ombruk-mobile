import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/serviceLocator.dart';

import 'package:ombruk/businessLogic/WeightReportViewModel.dart';

import 'package:ombruk/ui/tabs/weightreport/ListElementWithoutWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/ListElementWithWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportDialog.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

class WeightReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => serviceLocator<WeightReportViewModel>(),
      child: Consumer<WeightReportViewModel>(
        builder: (
          context,
          WeightReportViewModel weightReportViewModel,
          child,
        ) {
          return _WeightReportScreenConsumed(
            weightReportViewModel: weightReportViewModel,
          );
        },
      ),
    );
  }
}

class _WeightReportScreenConsumed extends StatefulWidget {
  final WeightReportViewModel weightReportViewModel;

  _WeightReportScreenConsumed({@required this.weightReportViewModel});

  @override
  _WeightReportScreenStateConsumer createState() =>
      _WeightReportScreenStateConsumer();
}

class _WeightReportScreenStateConsumer
    extends State<_WeightReportScreenConsumed> {
  bool _initialLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Wait for the build to finish before calling _fetchData, so
      // that the uiHelper.showLoading works
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: customColors.osloWhite,
        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (!_initialLoaded) {
      return Center(child: CircularProgressIndicator());
    }
    if (widget.weightReportViewModel.nonReportedList == null ||
        widget.weightReportViewModel.reportedList == null) {
      return _tryAgainWidget('Kunne ikke hente data');
    }
    if (widget.weightReportViewModel.nonReportedList.isEmpty &&
        widget.weightReportViewModel.reportedList.isEmpty) {
      return _tryAgainWidget('Ingen uttak funnet');
    }
    return RefreshIndicator(
      onRefresh: _fetchData,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: _buildList(),
      ),
    );
  }

  Widget _tryAgainWidget(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          RaisedButton(
            child: Text('Last inn p?? nytt'),
            onPressed: _fetchData,
          )
        ],
      ),
    );
  }

  Future<void> _fetchData() async {
    final bool success =
        await widget.weightReportViewModel.fetchWeightReports();
    if (!success) {
      uiHelper.showSnackbar(context, 'Kunne ikke hente vekt rapporter');
    }
    setState(() {
      _initialLoaded = true;
    });
  }

  List<Widget> _buildList() {
    List<Widget> list = [];
    list.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'Vektuttak',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    ));
    list.add(_subtitle('Ikke rapportert'));
    for (WeightReport weightReport
        in widget.weightReportViewModel.nonReportedList) {
      list.add(
        ListElementWithoutWeight(
          weightReport,
          () => _showNewWeightDialog(weightReport: weightReport),
        ),
      );
    }
    list.add(_subtitle('Tidligere uttak'));
    for (WeightReport weightReport
        in widget.weightReportViewModel.reportedList) {
      list.add(
        ListElementWithWeight(
          weightReport,
          () => _showWeightEditDialog(weightReport: weightReport),
        ),
      );
    }
    return list;
  }

  Future<void> _showNewWeightDialog({
    @required WeightReport weightReport,
  }) async {
    Future<void> _submitNewWeight(int newWeight) async {
      uiHelper.showLoading(context);
      final bool success =
          await widget.weightReportViewModel.addWeight(weightReport, newWeight);
      uiHelper.hideLoading(context);
      if (success) {
        Navigator.pop(context); // Close popup
        uiHelper.showSnackbar(context, 'OK!');
      } else {
        uiHelper.showSnackbar(context, 'Kunne ikke rapportere vekten');
      }
    }

    showDialog(
      context: context,
      builder: (_) {
        return WeightReportDialog(
          onSubmit: (int newWeight) {
            _submitNewWeight(newWeight);
          },
        );
      },
    );
  }

  Future<void> _showWeightEditDialog({
    @required WeightReport weightReport,
  }) async {
    Future<void> _updateWeight(int eventID, int newWeight) async {
      uiHelper.showLoading(context);
      final bool success = await widget.weightReportViewModel
          .updateWeight(weightReport, newWeight);
      uiHelper.hideLoading(context);

      if (success) {
        Navigator.pop(context); // Close popup
        uiHelper.showSnackbar(context, 'OK!');
      } else {
        uiHelper.showSnackbar(context, 'Kunne ikke rapportere vekten');
      }
    }

    showDialog(
      context: context,
      builder: (_) {
        return WeightReportDialog(
            onSubmit: (int newWeight) {
              _updateWeight(weightReport.eventID, newWeight);
            },
            initialWeight: weightReport.weight);
      },
    );
  }

  Widget _subtitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

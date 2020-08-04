import 'package:flutter/material.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/CalendarEventWithWeight.dart';
import 'package:ombruk/businessLogic/CalendarViewModel.dart';
import 'package:ombruk/businessLogic/WeightReportViewModel.dart';
import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/ui/tabs/weightreport/ListElementWithoutWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/ListElementWithWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportDialog.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class WeightReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => serviceLocator<WeightReportViewModel>(),
      child: Consumer2<CalendarViewModel, WeightReportViewModel>(
        builder: (
          context,
          CalendarViewModel calendarViewModel,
          WeightReportViewModel weightReportViewModel,
          child,
        ) {
          return _WeightReportScreenConsumed(
            calendarViewModel,
            weightReportViewModel,
          );
        },
      ),
    );
  }
}

class _WeightReportScreenConsumed extends StatefulWidget {
  final CalendarViewModel calendarViewModel;
  final WeightReportViewModel weightReportViewModel;

  _WeightReportScreenConsumed(
      this.calendarViewModel, this.weightReportViewModel);

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: customIcons.image(customIcons.arrowLeft),
          onPressed: () => null,
        ),
        title: Text(
          'Vektuttak',
          style: TextStyle(color: customColors.osloBlack),
        ),
        backgroundColor: customColors.osloWhite,
      ),
      backgroundColor: customColors.osloWhite,
      body: _initialLoaded
          ? widget.weightReportViewModel.calendarEvents == null ||
                  widget.weightReportViewModel.calendarEventsWithWeight == null
              ? _tryAgainWidget('Kunne ikke hente data')
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: widget.weightReportViewModel.calendarEvents.isEmpty &&
                          widget.weightReportViewModel.calendarEventsWithWeight
                              .isEmpty
                      ? _tryAgainWidget('Ingen uttak funnet')
                      : ListView(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          children: _buildList(),
                        ),
                )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _tryAgainWidget(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(text),
          RaisedButton(
            child: Text('Last inn på nytt'),
            onPressed: _fetchData,
          )
        ],
      ),
    );
  }

  Future<void> _fetchData() async {
    print('fetch');
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
    list.add(_subtitle('Ikke rapportert'));
    for (CalendarEvent calendarEvent
        in widget.weightReportViewModel.calendarEvents) {
      list.add(
        ListElementWithoutWeight(
          calendarEvent,
          () => _showNewWeightDialog(calendarEvent.id),
        ),
      );
    }
    list.add(_subtitle('Tidligere uttak'));
    for (CalendarEventWithWeight event
        in widget.weightReportViewModel.calendarEventsWithWeight) {
      list.add(
        ListElementWithWeight(
          event.calendarEvent,
          event.weightReport,
          () => _showWeightEditDialog(
            eventID: event.calendarEvent.id,
            initialWeight: event.weightReport.weight,
          ),
        ),
      );
    }
    return list;
  }

  Future<void> _showNewWeightDialog(int id) async {
    Future<void> _submitNewWeight(int weight) async {
      uiHelper.showLoading(context);
      final bool success =
          await widget.weightReportViewModel.addWeight(id, weight);
      uiHelper.hideLoading(context);

      if (!success) {
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
    @required int eventID,
    @required int initialWeight,
  }) async {
    Future<void> _updateWeight(int eventID, int newWeight) async {
      uiHelper.showLoading(context);
      final bool success =
          await widget.weightReportViewModel.updateWeight(eventID, newWeight);
      uiHelper.hideLoading(context);

      if (!success) {
        uiHelper.showSnackbar(context, 'Kunne ikke rapportere vekten');
      }
    }

    showDialog(
      context: context,
      builder: (_) {
        return WeightReportDialog(
            onSubmit: (int newWeight) {
              _updateWeight(eventID, newWeight);
            },
            initialWeight: initialWeight);
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

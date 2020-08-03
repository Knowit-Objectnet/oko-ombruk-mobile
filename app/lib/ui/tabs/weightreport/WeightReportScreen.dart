import 'package:flutter/material.dart';

import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/DataProvider/WeightReportClient.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/ui/tabs/weightreport/ListElementWithoutWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/ListElementWithWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportDialog.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:provider/provider.dart';

class WeightReportScreen extends StatefulWidget {
  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserViewModel userViewModel, child) {
        return _WeightReportScreenConsumed(
          CalendarApiClient(userViewModel.accessToken),
          WeightReportClient(userViewModel.accessToken),
        );
      },
    );
  }
}

class _WeightReportScreenConsumed extends StatefulWidget {
  final CalendarApiClient calendarApiClient;
  final WeightReportClient weightReportClient;

  _WeightReportScreenConsumed(this.calendarApiClient, this.weightReportClient);

  @override
  _WeightReportScreenStateConsumer createState() =>
      _WeightReportScreenStateConsumer();
}

class _WeightReportScreenStateConsumer
    extends State<_WeightReportScreenConsumed> {
  List<CalendarEvent> _nonReportedList;
  List<_EventWithWeight> _reportedList;
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
          ? _nonReportedList == null || _reportedList == null
              ? _tryAgainWidget('Kunne ikke hente data')
              : RefreshIndicator(
                  onRefresh: _fetchData,
                  child: _nonReportedList.isEmpty && _reportedList.isEmpty
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
    try {
      Future<CustomResponse> futureEvents =
          widget.calendarApiClient.fetchEvents();
      Future<CustomResponse> futureResponse =
          widget.weightReportClient.fetchWeightReports();
      await Future.wait<CustomResponse>([futureEvents, futureResponse],
          eagerError: true, cleanUp: (_) {
        uiHelper.showSnackbar(context, 'Kunne ikke hente vekt rapporter');
      }).then((responses) {
        if (!responses[0].success || !responses[1].success) {
          print(responses[0]);
          print(responses[1]);
          throw Exception();
        }
        _buildLists(responses[0].data, responses[1].data);
      });
    } catch (e) {
      print(e);
      uiHelper.showSnackbar(context, 'Kunne ikke hente vekt rapporter');
    } finally {
      setState(() {
        _initialLoaded = true;
      });
    }
  }

  void _buildLists(
      List<CalendarEvent> calendarEvents, List<WeightReport> weightReports) {
    List<CalendarEvent> nonReportedListTemp = [];
    List<_EventWithWeight> reportedListTemp = [];

    for (CalendarEvent calendarEvent in calendarEvents) {
      WeightReport weightReport = weightReports.firstWhere(
          (element) => element.eventID == calendarEvent.id,
          orElse: () => null);
      if (weightReport?.weight != null) {
        reportedListTemp.add(_EventWithWeight(calendarEvent, weightReport));
      } else {
        nonReportedListTemp.add(calendarEvent);
      }
    }
    setState(() {
      _nonReportedList = nonReportedListTemp;
      _reportedList = reportedListTemp;
    });
  }

  List<Widget> _buildList() {
    List<Widget> list = [];
    list.add(_subtitle('Ikke rapportert'));
    for (CalendarEvent calendarEvent in _nonReportedList) {
      list.add(
        ListElementWithoutWeight(
          calendarEvent,
          () => _showNewWeightDialog(calendarEvent.id),
        ),
      );
    }
    list.add(_subtitle('Tidligere uttak'));
    for (_EventWithWeight event in _reportedList) {
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
      final CustomResponse response =
          await widget.weightReportClient.addWeight(id, weight);
      uiHelper.hideLoading(context);

      if (response.success) {
        final WeightReport weightReport = response.data;
        final CalendarEvent calendarEvent =
            _nonReportedList.firstWhere((event) => event.id == id);

        Navigator.of(context).pop(); // Pop dialog
        uiHelper.showSnackbar(context, 'OK!');

        setState(() {
          _nonReportedList.remove(calendarEvent);
          _reportedList.add(_EventWithWeight(calendarEvent, weightReport));
        });
      } else {
        print(response);
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
      final CustomResponse response =
          await widget.weightReportClient.addWeight(eventID, newWeight);
      uiHelper.hideLoading(context);

      if (response.success) {
        final WeightReport weightReport = response.data;
        final _EventWithWeight event = _reportedList
            .firstWhere((element) => element.calendarEvent.id == eventID);
        final int index = _reportedList.indexOf(event);

        Navigator.of(context).pop(); // Pop dialog
        uiHelper.showSnackbar(context, 'OK!');

        setState(() {
          _reportedList.removeAt(index);
          _reportedList.insert(
              index, _EventWithWeight(event.calendarEvent, weightReport));
        });
      } else {
        uiHelper.showSnackbar(context, 'Kunne ikke oppdatere vekten');
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

class _EventWithWeight {
  final CalendarEvent calendarEvent;
  final WeightReport weightReport;

  _EventWithWeight(this.calendarEvent, this.weightReport);
}

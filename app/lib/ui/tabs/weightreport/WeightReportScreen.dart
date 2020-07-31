import 'package:flutter/material.dart';

import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/DataProvider/WeightReportClient.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/ui/tabs/weightreport/ListElementWithoutWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/ListElementWithWeight.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportDialog.dart';
import 'package:ombruk/ui/ui.helper.dart';
import 'package:ombruk/ui/tabs/TokenHolder.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class WeightReportScreen extends StatefulWidget {
  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  final WeightReportClient _weightReportClient = WeightReportClient();

  CalendarApiClient _calendarClient;
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
    String token = TokenHolder.of(context).token;
    _calendarClient = CalendarApiClient(token);

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
                  child: _nonReportedList.isEmpty
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
      Future<CustomResponse> futureEvents = _calendarClient.fetchEvents();
      Future<CustomResponse> futureResponse =
          _weightReportClient.fetchWeightReports();
      await Future.wait<CustomResponse>([futureEvents, futureResponse],
          eagerError: true, cleanUp: (_) {
        uiHelper.showSnackbar(context, 'Kunne ikke hente vekt rapporter');
      }).then((value) {
        _buildLists(value[0].data, value[1].data);
      });
    } catch (_e) {
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
          (element) => element.event.id == calendarEvent.id,
          orElse: () => null);
      if (weightReport != null) {
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

  // TODO: pass partnerID instead of 1
  List<Widget> _buildList() {
    List<Widget> list = [];
    list.add(_subtitle('Ikke rapportert'));
    for (CalendarEvent calendarEvent in _nonReportedList) {
      list.add(ListElementWithoutWeight(calendarEvent,
          () => _showNewWeightDialog(eventID: calendarEvent.id, partnerID: 1)));
    }
    list.add(_subtitle('Tidligere uttak'));
    for (_EventWithWeight event in _reportedList) {
      list.add(ListElementWithWeight(
          event.calendarEvent,
          event.weightReport,
          () => _showWeightEditDialog(
              eventID: event.calendarEvent.id,
              partnerID: 1,
              initialWeight: event.weightReport.weight)));
    }
    return list;
  }

  Future<void> _showNewWeightDialog(
      {@required int eventID, @required int partnerID}) async {
    Future<void> _submitNewWeight(
        int eventID, int partnerID, int weight) async {
      uiHelper.showLoading(context);
      final CustomResponse response =
          await _weightReportClient.addWeight(eventID, partnerID, weight);
      uiHelper.hideLoading(context);

      if (response.success) {
        final WeightReport weightReport = response.data;
        final CalendarEvent calendarEvent =
            _nonReportedList.firstWhere((event) => event.id == eventID);

        Navigator.of(context).pop(); // Pop dialog
        uiHelper.showSnackbar(context, 'OK!');

        setState(() {
          _nonReportedList.remove(calendarEvent);
          _reportedList.add(_EventWithWeight(calendarEvent, weightReport));
        });
      } else {
        uiHelper.showSnackbar(context, 'Kunne ikke rapportere vekten');
      }
    }

    showDialog(
      context: context,
      builder: (_) {
        return WeightReportDialog(
          onSubmit: (int newWeight) {
            _submitNewWeight(eventID, partnerID, newWeight);
          },
        );
      },
    );
  }

  Future<void> _showWeightEditDialog({
    @required int eventID,
    @required int partnerID,
    @required int initialWeight,
  }) async {
    Future<void> _updateWeight(
        int eventID, int partnerID, int newWeight) async {
      uiHelper.showLoading(context);
      final CustomResponse response =
          await _weightReportClient.addWeight(eventID, partnerID, newWeight);
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
              _updateWeight(eventID, partnerID, newWeight);
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

  /*List<Widget> _buildListWithSeperators() {
    Widget _textDivider(String text) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(text,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0)),
      );
    }

    List<Widget> list = [];
    list.add(_textDivider('Siste uttak'));
    for (int index = 0; index < _weightReports.length; index++) {
      if (index == 1) {
        list.add(_textDivider('Tidligere uttak'));
      }
      list.add(_weightElement(_weightReports[index]));
    }
    return list;
  }*/
}

class _EventWithWeight {
  final CalendarEvent calendarEvent;
  final WeightReport weightReport;

  _EventWithWeight(this.calendarEvent, this.weightReport);
}

import 'package:flutter/cupertino.dart';
import 'package:ombruk/businessLogic/CalendarEventWithWeight.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/CalendarService.dart';
import 'package:ombruk/services/WeightReportService.dart';
import 'package:ombruk/services/serviceLocator.dart';

class WeightReportViewModel extends ChangeNotifier {
  final WeightReportService _weightReportService =
      serviceLocator<WeightReportService>(); // TODO init in screen
  final CalendarService _calendarService = serviceLocator<CalendarService>();

// TODO Make unmodifiable list
  List<CalendarEvent> _calendarEvents;
  List<CalendarEventWithWeight> _calendarEventsWithWeight;

  List<CalendarEvent> get calendarEvents => _calendarEvents;
  List<CalendarEventWithWeight> get calendarEventsWithWeight =>
      _calendarEventsWithWeight;

  Future<bool> fetchWeightReports() async {
    final Future<CustomResponse<List<WeightReport>>> futureWeightResponse =
        _weightReportService.fetchWeightReports();

    final Future<CustomResponse<List<CalendarEvent>>> futureCalendarResponse =
        _calendarService.fetchEvents();

    final CustomResponse<List<WeightReport>> weightResponse =
        await futureWeightResponse;
    final CustomResponse<List<CalendarEvent>> calendarResponse =
        await futureCalendarResponse;

    if (weightResponse.success && calendarResponse.success) {
      List<CalendarEvent> tempCalendarEvents = [];
      List<CalendarEventWithWeight> tempCalendarEventsWithWeight = [];

      for (CalendarEvent calendarEvent in calendarResponse.data) {
        WeightReport weightReport = weightResponse.data
            .firstWhere((element) => element.eventID == calendarEvent.id);
        if (weightReport?.weight != null) {
          tempCalendarEventsWithWeight
              .add(CalendarEventWithWeight(calendarEvent, weightReport));
        } else {
          tempCalendarEvents.add(calendarEvent);
        }
      }
      _calendarEvents = tempCalendarEvents;
      _calendarEventsWithWeight = tempCalendarEventsWithWeight;

      notifyListeners();
      return true;
    } else {
      print(weightResponse);
      print(calendarResponse);
      return false;
    }
  }

  Future<bool> addWeight(int id, int weight) async {
    final CustomResponse<WeightReport> response =
        await _weightReportService.addWeight(id, weight);

    if (response.success) {
      final WeightReport weightReport = response.data;
      final CalendarEvent calendarEvent =
          _calendarEvents.firstWhere((event) => event.id == id);

      _calendarEvents.remove(calendarEvent);
      _calendarEventsWithWeight
          .add(CalendarEventWithWeight(calendarEvent, weightReport));

      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> updateWeight(int id, int weight) async {
    final CustomResponse<WeightReport> response =
        await _weightReportService.addWeight(id, weight);

    if (response.success) {
      final WeightReport weightReport = response.data;
      final CalendarEventWithWeight eventWithWeight = _calendarEventsWithWeight
          .firstWhere((element) => element.calendarEvent.id == id);
      final int index = _calendarEventsWithWeight.indexOf(eventWithWeight);

      _calendarEventsWithWeight.removeAt(index);
      _calendarEventsWithWeight.insert(index,
          CalendarEventWithWeight(eventWithWeight.calendarEvent, weightReport));

      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }
}

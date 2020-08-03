import 'package:flutter/material.dart';

import 'package:ombruk/businessLogic/CalendarModel.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/CalendarService.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

class CalendarViewModel extends ChangeNotifier {
  final CalendarService _calendarService = serviceLocator<CalendarService>();

  CalendarModel _calendarModel;
  bool _isLoading = false;

  List<CalendarEvent> get calendarEvents => _calendarModel?.calendarEvents;
  bool get isLoading => _isLoading;

  Future<void> fetchEvents({int stationID, int partnerID}) async {
    _isLoading = true;
    notifyListeners();
    final CustomResponse<List<CalendarEvent>> response =
        await _calendarService.fetchEvents(
      stationID: stationID,
      partnerID: partnerID,
    );

    _isLoading = false;
    if (response.success) {
      _calendarModel = CalendarModel(response.data);
    } else {
      print(response);
      _calendarModel = null;
    }
    notifyListeners();
  }

  Future<bool> createCalendarEvent(CreateCalendarEventData eventData) async {
    final CustomResponse response =
        await _calendarService.createCalendarEvent(eventData);
    if (response.success) {
      fetchEvents();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> deleteCalendarEvent(int id, DateTime startDate, DateTime endDate,
      dynamic recurrenceRuleID) async {
    final CustomResponse response = await _calendarService.deleteCalendarEvent(
        id, startDate, endDate, recurrenceRuleID);
    if (response.success) {
      fetchEvents();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> updateEvent(
      int id, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    final CustomResponse response =
        await _calendarService.updateEvent(id, date, startTime, endTime);
    if (response.success) {
      fetchEvents(); // Lazy stuff
      return true;
    } else {
      print(response);
      return false;
    }
  }

  // TODO Add try again 401 auth on many of these
}

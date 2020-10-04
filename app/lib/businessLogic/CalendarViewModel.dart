import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/CalendarService.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/serviceLocator.dart';

class CalendarViewModel extends ChangeNotifier {
  final CalendarService _calendarService = serviceLocator<CalendarService>();

  List<CalendarEvent> _calendarEvents;
  bool _isLoading = true;

  CalendarViewModel() {
    fetchEvents();
  }

  List<CalendarEvent> get calendarEvents => _calendarEvents;
  bool get isLoading => _isLoading;

  Future<void> fetchEvents({int stationID, int partnerID}) async {
    _isLoading = true;
    notifyListeners();
    EventGetForm form =
        EventGetForm(stationId: stationID, partnerId: partnerID);
    final CustomResponse<List<CalendarEvent>> response =
        await _calendarService.fetchEvents(form);

    _isLoading = false;
    if (response.success) {
      _calendarEvents = response.data;
    } else {
      print(response);
      _calendarEvents = null;
    }
    notifyListeners();
  }

  Future<bool> createCalendarEvent(
    DateTime startDate,
    DateTime endDate,
    TimeOfDay startTime,
    TimeOfDay endTime,
    int stationId,
    int partnerId,
    List<Weekdays> days,
    int interval,
  ) async {
    bool isRecurring =
        days != null || interval != null || startDate.day != endDate.day;
    if (isRecurring && interval == 0) {
      interval = 1;
    }
    DateTime startDateTime = DateTime(startDate.year, startDate.month,
        startDate.day, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(endDate.year, endDate.month, endDate.day,
        startTime.hour, startTime.minute);
    EventPostForm form = EventPostForm(
        startDateTime,
        endDateTime,
        stationId,
        partnerId,
        isRecurring ? RecurrenceRule(days: days, interval: interval) : null);

    CustomResponse response = await _calendarService.createCalendarEvent(form);
    if (response.success) {
      fetchEvents(); // Lazy stuff
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> deleteCalendarEvent(int id, DateTime startDate, DateTime endDate,
      dynamic recurrenceRuleID) async {
    EventDeleteForm form = EventDeleteForm(
      eventId: id,
      startDateTime: startDate,
      endDateTime: endDate,
      recurrenceRuleId: recurrenceRuleID,
    );
    final CustomResponse response =
        await _calendarService.deleteCalendarEvent(form);
    if (response.success) {
      fetchEvents(); // Lazy stuff
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> updateEvent(
      int id, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    DateTime startDateTime;
    DateTime endDateTime;

    //Null checks, just in case.
    if (date != null) {
      if (startTime != null) {
        startDateTime = DateTime(
            date.year, date.month, date.day, startTime.hour, startTime.minute);
      }
      if (endTime != null) {
        endDateTime = DateTime(
            date.year, date.month, date.day, endTime.hour, endTime.minute);
      }
    }
    EventUpdateForm form = EventUpdateForm(
        eventId: id, startDateTime: startDateTime, endDateTime: endDateTime);
    final CustomResponse response = await _calendarService.updateEvent(form);
    if (response.success) {
      fetchEvents(); // Lazy stuff
      return true;
    } else {
      print(response);
      return false;
    }
  }
}

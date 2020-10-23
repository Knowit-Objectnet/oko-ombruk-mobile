import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class CalendarViewModel extends BaseViewModel {
  final ICalendarService _calendarService;
  IStationService _stationService;

  bool _showHorizontal = true;
  bool get showHorizontalCalendar => _showHorizontal;

  List<CalendarEvent> _calendarEvents = [];
  bool _isLoading = true;
  Station _selectedStation;
  Station get selectedStation => _selectedStation;

  List<Station> _stations = [];
  List<Station> get stations => _stations;

  CalendarViewModel(this._calendarService, this._stationService) {
    fetchEvents();
  }

  Future<void> start() async {
    await fetchEvents();
    CustomResponse response =
        await _stationService.fetchStations(StationGetForm());
    if (!response.success) throw Exception("Failed to get stations");
    _stations = response.data;
    _selectedStation = _stations.first;
    setState(ViewState.Idle);
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

  List<CalendarEvent> get currentStationEvents {
    if (calendarEvents == null) {
      return [];
    }
    if (selectedStation == null) {
      return [];
    }
    return calendarEvents
        .where((element) => element.station.name == selectedStation.name)
        .toList();
  }

  void onStationChanged(Station value) {
    _selectedStation = value;
    notifyListeners();
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

import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/OpeningHours.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

enum CancellationType { Once, Until }

class CalendarEventExpandedModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  final ICalendarService _calendarService;
  final SnackbarService _snackbarService;
  final DialogService _dialogService;
  CalendarEvent _event;
  CalendarEventExpandedModel(
    this._event,
    this._calendarService,
    this._snackbarService,
    this._dialogService,
    this._authenticationService,
  ) {
    KeycloakRoles role = getRole(_authenticationService.userModel.roles
        .firstWhere((role) => getRole(role) != null, orElse: () => null));
    if (role == null) {
      _canEdit = false;
    }
    if (role == KeycloakRoles.reg_employee) {
      _canEdit = true;
    }
    if (role == KeycloakRoles.partner &&
        _authenticationService.userModel.groupID == event.partner.id) {
      _canEdit = true;
    }

    init();
  }

  GlobalKey<FormState> _updateFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get updateFormKey => _updateFormKey;

  GlobalKey<FormState> _deleteFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get deleteFormKey => _deleteFormKey;

  void init() {
    _date = _event.startDateTime;
    _startTime = TimeOfDay(
      hour: _event.startDateTime.hour,
      minute: _event.startDateTime.minute,
    );
    _endTime = TimeOfDay(
      hour: _event.endDateTime.hour,
      minute: _event.endDateTime.minute,
    );
  }

  CalendarEvent get event => _event;

  DateTime _date;
  DateTime get date => _date;

  TimeOfDay _startTime;
  TimeOfDay get startTime => _startTime;

  TimeOfDay _endTime;
  TimeOfDay get endTime => _endTime;

  bool _editing = false;
  bool get isEditing => _editing;

  int get minTime => _event.station.hours[_date.weekday]?.opensAt?.hour ?? 8;
  int get maxTime => _event.station.hours[_date.weekday]?.closesAt?.hour ?? 16;

  bool _canEdit = false;
  bool get hasPrivileges => _canEdit;

  bool _expanded = false;
  bool get isExpanded => _expanded;

  CancellationType cancellationType = CancellationType.Once;

  DateTime _cancelUntilDateTime;
  DateTime get cancelUntilDateTime => _cancelUntilDateTime;

  String validateDate(DateTime value) {
    DateTime currentTime = DateTime.now();
    DateTime compare =
        DateTime(currentTime.year, currentTime.month, currentTime.day);
    if (value.isBefore(compare)) {
      return "Kan ikke være før nåtid!";
    }
    if (!_event.station.hours.containsKey(value.weekday)) {
      return "Stasjonen er stengt denne dagen!";
    }
    return null;
  }

  String validateTime(TimeOfDay value) {
    if (_startTime.hour > _endTime.hour ||
        _startTime.hour == endTime.hour &&
            _startTime.minute >= endTime.minute) {
      return "Starttidspunkt må være før sluttidspunkt!";
    }
    OpeningHours openingHours = event.station.hours[_date.weekday];
    if (openingHours == null) return null;
    if (value.hour < openingHours.opensAt.hour ||
        value.hour == openingHours.opensAt.hour &&
            value.minute < openingHours.opensAt.minute) {
      return "Må være etter ${DateUtils.timeOfDayToString(openingHours.opensAt)}";
    }
    if (value.hour > openingHours.closesAt.hour ||
        value.hour == openingHours.closesAt.hour &&
            value.minute >= openingHours.closesAt.minute) {
      return "Må være før ${DateUtils.timeOfDayToString(openingHours.closesAt)}";
    }
    return null;
  }

  String validateUntilDate(DateTime value) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    if (value.isBefore(today)) {
      return "Kan ikke slette hendelser som allerede har skjedd!";
    }
    return null;
  }

  void setEditing() {
    _editing = !_editing;
    if (!_editing) {
      init();
    }
    notifyListeners();
  }

  void cancelExpanded() {
    _expanded = !_expanded;
    if (_expanded) {
      _cancelUntilDateTime = _event.endDateTime;
    }
    notifyListeners();
  }

  void onCancelTypeChanged(CancellationType type) {
    cancellationType = type;
    notifyListeners();
  }

  void onCancelEndChanged(DateTime endDateTime) {
    _cancelUntilDateTime = endDateTime;
    notifyListeners();
  }

  void onDateChanged(DateTime date) {
    _date = date;
    notifyListeners();
  }

  void onTimeChanged(TimeType type, TimeOfDay newTime) {
    if (type == TimeType.Start) {
      _startTime = newTime;
    } else {
      _endTime = newTime;
    }
    notifyListeners();
  }

  void deleteEvents() async {
    if (validateUntilDate(_cancelUntilDateTime) != null) return;
    EventDeleteForm form;
    if (cancellationType == CancellationType.Once ||
        _event.recurrenceRule.id == null) {
      form = EventDeleteForm(eventId: _event.id);
    } else if (cancellationType == CancellationType.Until) {
      form = EventDeleteForm(
        recurrenceRuleId: _event.recurrenceRule.id,
        startDateTime: _event.startDateTime,
        endDateTime: _cancelUntilDateTime,
      );
    }
    CustomResponse response = await _calendarService.deleteCalendarEvent(form);
    if (!response.success) {
      _snackbarService.showSimpleSnackbar("Kunne ikke slette hendelse!");
      print(response.message);
    } else {
      _snackbarService.showSimpleSnackbar("Hendelse slettet!");
    }
  }

  void updateCalendarEvent() async {
    if (!_updateFormKey.currentState.validate()) return;
    DateTime startDateTime = DateUtils.fromTimeOfDay(date, _startTime);
    DateTime endDateTime = DateUtils.fromTimeOfDay(date, _endTime);
    _dialogService.showLoading();
    if (startDateTime.isAtSameMomentAs(_event.startDateTime)) {
      startDateTime = null;
    }
    if (endDateTime.isAtSameMomentAs(_event.endDateTime)) {
      endDateTime = null;
    }
    if (startDateTime != null || endDateTime != null) {
      print("updating");
      EventUpdateForm form = EventUpdateForm(
        eventId: _event.id,
        startDateTime: startDateTime,
        endDateTime: endDateTime,
      );
      CustomResponse response = await _calendarService.updateEvent(form);
      if (response.success) {
        print(response.data);
        _event = response.data;
        init();
      } else {
        _dialogService.hideLoading();
        _snackbarService.showSimpleSnackbar("Klarte ikke oppdatere hendelse");
        return;
      }
    }
    _editing = false;
    _dialogService.hideLoading();
    _snackbarService.showSimpleSnackbar("Oppdaterte hendelse");
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

enum CancellationType { Once, Until }

enum TimeType { Start, End }

class CalendarEventExpandedModel extends BaseViewModel {
  final ICalendarService _calendarService;
  final SnackbarService _snackbarService;
  final DialogService _dialogService;
  CalendarEvent _event;
  CalendarEventExpandedModel(
    this._event,
    this._calendarService,
    this._snackbarService,
    this._dialogService,
  ) {
    init();
  }

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

  bool _expanded = false;
  bool get isExpanded => _expanded;

  CancellationType cancellationType = CancellationType.Once;

  DateTime _cancelUntilDateTime;
  DateTime get cancelUntilDateTime => _cancelUntilDateTime;

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
    EventDeleteForm form;
    if (cancellationType == CancellationType.Once) {
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
    } else {
      _snackbarService.showSimpleSnackbar("Hendelse slettet!");
    }
  }

  void updateCalendarEvent() async {
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

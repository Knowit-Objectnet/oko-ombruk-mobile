import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

enum TimeType { Start, End }

class CreateCalendarEventModel extends BaseViewModel {
  final DialogService _dialogService;
  final INavigatorService _navigatorService;
  final ICalendarService _calendarService;
  final SnackbarService _snackbarService;
  final Partner _partner;
  final Station _station;

  final Map<String, int> _intervals = {
    'Ukentlig': 1,
    'Annenhver uke': 2,
  };
  Map<String, int> get intervals => _intervals;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController _merknadController = TextEditingController();
  TextEditingController get merknadController => _merknadController;

  List<Weekdays> _selectedWeekDays = List();
  List<Weekdays> get selectedWeekdays => _selectedWeekDays;

  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay get startTime => _startTime;

  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay get endTime => _endTime;

  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;

  DateTime _endDate = DateTime.now();
  DateTime get endDate => _endDate;

  void onDateChanged(TimeType type, DateTime value) {
    if (type == TimeType.Start) {
      _startDate = value;
    } else {
      _endDate = value;
    }
    notifyListeners();
  }

  void onTimeChanged(TimeType type, TimeOfDay value) {
    if (type == TimeType.Start) {
      _startTime = value;
    } else {
      _endTime = value;
    }
    notifyListeners();
  }

  void onWeekdayChanged(Weekdays value) {
    if (_selectedWeekDays.contains(value)) {
      _selectedWeekDays.remove(value);
    } else {
      _selectedWeekDays.add(value);
    }
    notifyListeners();
  }

  CreateCalendarEventModel(this._station, this._partner, this._calendarService,
      this._navigatorService, this._dialogService, this._snackbarService) {
    _chosenInterval = _intervals.entries.first.key;
  }

  String _chosenInterval;
  String get chosenInterval => _chosenInterval;

  void onIntervalChanged(String value) {
    _chosenInterval = value;
    notifyListeners();
  }

  void onSubmit() async {
    _dialogService.showLoading();
    DateTime startDateTime = DateTime(startDate.year, startDate.month,
        startDate.day, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(
        endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);

    RecurrenceRule recurrenceRule;
    if (startDate != endDate) {
      recurrenceRule = RecurrenceRule(
        days: _selectedWeekDays,
        until: endDateTime,
        interval: _intervals[_chosenInterval],
      );
    }
    print(endTime);
    print(startDateTime);
    print(endDateTime);
    EventPostForm form = EventPostForm(
      startDateTime,
      endDateTime,
      _station.id,
      _partner.id,
      recurrenceRule,
    );
    CustomResponse response = await _calendarService.createCalendarEvent(form);
    _dialogService.hideLoading();
    if (!response.success) {
      print("error: ${response.message}");
      _snackbarService.showSimpleSnackbar("Kunne ikke opprette hendelse");
    } else {
      _navigatorService.popStack();
      _snackbarService.showSimpleSnackbar("Hendelse opprettet!");
    }
  }

  @override
  void dispose() {
    _merknadController.dispose();
    super.dispose();
  }
}

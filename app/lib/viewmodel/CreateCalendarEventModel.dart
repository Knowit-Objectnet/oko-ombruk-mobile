import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/const/UttaksType.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

import 'package:ombruk/utils/extensions/TimeOfDayExtensions.dart';

class CreateCalendarEventModel extends BaseViewModel {
  final DialogService _dialogService;
  final INavigatorService _navigatorService;
  final ICalendarService _calendarService;
  final SnackbarService _snackbarService;
  final Partner _partner;
  final Station _station;

  final Set<String> _intervals = UttaksType.values;
  Set get intervals => _intervals;

  String _chosenInterval;
  String get chosenInterval => _chosenInterval;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  TextEditingController _merknadController = TextEditingController();
  TextEditingController get merknadController => _merknadController;

  Set<int> _selectedWeekdays = Set();
  Set<int> get selectedWeekdays => _selectedWeekdays;

  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay get startTime => _startTime;

  int get minTime => _station.hours[_startDate.weekday].opensAt.hour;
  int get maxTime => _station.hours[_startDate.weekday].closesAt.hour;

  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay get endTime => _endTime;

  DateTime _startDate = DateTime.now();
  DateTime get startDate => _startDate;

  DateTime _endDate = DateTime.now();
  DateTime get endDate => _endDate;

  @override
  Future<void> init() {
    // TODO: implement init
  }

  void onDateChanged(TimeType type, DateTime value) {
    if (type == TimeType.Start) {
      _startDate = value;
    } else {
      _endDate = value;
    }
    notifyListeners();
  }

  String validateTime(TimeOfDay value) {
    if (_startTime >= _endTime) {
      return "Start må være før slutt!";
    }
    if (value < _station.hours[_startDate.weekday].opensAt) {
      return "Kan ikke være før stasjonens åpningstid!";
    }
    if (value > _station.hours[_endDate.weekday].closesAt) {
      return "Kan ikke være etter stasjonens stengetid!";
    }
    return null;
  }

  String validateDate(DateTime time) {
    return null;
  }

  void onTimeChanged(TimeType type, TimeOfDay value) {
    if (type == TimeType.Start) {
      _startTime = value;
    } else {
      _endTime = value;
    }
    notifyListeners();
  }

  void onWeekdayChanged(int value) {
    if (_selectedWeekdays.contains(value)) {
      _selectedWeekdays.remove(value);
    } else {
      _selectedWeekdays.add(value);
    }
    notifyListeners();
  }

  CreateCalendarEventModel(this._station, this._partner, this._calendarService,
      this._navigatorService, this._dialogService, this._snackbarService) {
    _chosenInterval = _intervals.first;
  }

  void onIntervalChanged(String value) {
    _chosenInterval = value;
    notifyListeners();
  }

  void onSubmit() async {
    _dialogService.showLoading();
    DateTime startDateTime = DateUtils.fromTimeOfDay(startDate, startTime);
    DateTime endDateTime = DateUtils.fromTimeOfDay(startDate, endTime);

    RecurrenceRule recurrenceRule;
    if (_chosenInterval != UttaksType.ENGANGSTILFELLE) {
      recurrenceRule = RecurrenceRule(
        days: _selectedWeekdays.map((i) => DateUtils.toWeekday(i)).toList(),
        until: DateUtils.fromTimeOfDay(endDate, endTime),
        interval: UttaksType.getInterval(_chosenInterval),
      );
    } else {
      endDateTime = DateUtils.fromTimeOfDay(startDate, endTime);
    }
    print(startDateTime);
    print(endDateTime);
    print(endTime);
    EventPostForm form = EventPostForm(
      startDateTime,
      endDateTime,
      _station.id,
      _partner.id,
      recurrenceRule,
    );
    print(form.encode());
    CustomResponse response = await _calendarService.createCalendarEvent(form);
    _dialogService.hideLoading();
    if (!response.success) {
      print("error: ${response.message}");
      print(response.statusCode);
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

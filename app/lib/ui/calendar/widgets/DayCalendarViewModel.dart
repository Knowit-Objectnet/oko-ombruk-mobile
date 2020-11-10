import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class DayCalendarViewModel extends BaseViewModel {
  DateTime _selectedDate = DateTime.now().subtract(Duration(days: 1));
  DateTime get selectedDate => _selectedDate;
  final Station _station;

  DayCalendarViewModel(this._station);

  TimeOfDay get opensAt =>
      _station.hours[_selectedDate.weekday]?.opensAt ??
      TimeOfDay(hour: 7, minute: 0);
  TimeOfDay get closesAt =>
      _station.hours[_selectedDate.weekday]?.closesAt ??
      TimeOfDay(hour: 21, minute: 0);

  bool get isClosed => !_station.hours.containsKey(_selectedDate.weekday);

  void onDayChanged(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}

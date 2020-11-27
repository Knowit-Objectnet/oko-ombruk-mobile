import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ombruk/models/OpeningHours.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/viewmodel/CreateCalendarEventModel.dart';

class NewStationViewModel extends BaseViewModel {
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;
  HashMap<int, OpeningHours> _stationHours = HashMap();
  TimeOfDay defaultOpens = TimeOfDay(hour: 7, minute: 0);
  TimeOfDay defaultCloses = TimeOfDay(hour: 16, minute: 0);
  NewStationViewModel() : super(state: ViewState.Busy) {
    DateUtils.weekdaysShort.entries.forEach((entry) =>
        _stationHours.putIfAbsent(
            entry.key, () => OpeningHours(defaultOpens, defaultCloses)));

    setState(ViewState.Idle);
  }

  @override
  Future<void> init() {
    // TODO: implement init
  }

  TimeOfDay dayOpensAt(int day) => _stationHours[day].opensAt;

  TimeOfDay dayClosesAt(int day) => _stationHours[day].closesAt;

  bool isDayClosed(int day) => _stationHours[day].isClosed;

  void onTimeChanged(TimeType type, int day, TimeOfDay value) {
    if (type == TimeType.Start) {
      _stationHours[day].opensAt = value;
    } else {
      _stationHours[day].closesAt = value;
    }
  }

  void onClosedChange(int day, bool val) {
    _stationHours[day].isClosed = val;
    notifyListeners();
  }

  void onSubmit() {}
}

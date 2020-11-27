import 'package:flutter/material.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class AddExtraPickupViewModel extends BaseViewModel {
  final IStationService _stationService;
  final IPickupService _pickupService;
  final SnackbarService _snackbarService;
  final DialogService _dialogService;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  Station _selectedStation;
  Station get selectedStation => _selectedStation;

  List<Station> _stations = List();
  List<Station> get stations => _stations;

  AddExtraPickupViewModel(
    this._stationService,
    this._pickupService,
    this._snackbarService,
    this._dialogService,
  ) : super(state: ViewState.Busy);

  @override
  Future<void> init() async {
    CustomResponse<List<Station>> response =
        await _stationService.fetchStations(StationGetForm());
    if (!response.success) {
      _snackbarService.showSimpleSnackbar("Klarte ikke hente stasjoner");
    } else {
      _stations = response.data;
    }
    setState(ViewState.Idle);
  }

  final TextEditingController _merknadController = TextEditingController();
  TextEditingController get merknadController => _merknadController;

  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay get startTime => _startTime;

  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay get endTime => _endTime;

  void onDateChanged(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  void onStationChanged(Station station) {
    _selectedStation = station;
    notifyListeners();
  }

  String validateDate(DateTime value) {
    DateTime currentDate = DateTime.now();
    DateTime compareDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    if (value.isBefore(compareDate)) {
      return "Valgt dato kan ikke være før nåtid!";
    }
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

  String validateStation(Station value) {
    if (value == null) {
      return "Vennligst velg en stasjon";
    }
    return null;
  }

  String validateStartTime(TimeOfDay value) {
    if (value == null) {
      return "Du må velge en verdi";
    }
    if (_endTime != null &&
        ((value.hour > _endTime.hour) ||
            value.hour == _endTime.hour && value.minute >= _endTime.minute)) {
      return "Starttid må være mindre enn sluttid!";
    }
    return null;
  }

  String validateEndTime(TimeOfDay value) {
    if (value == null) {
      return "Du må velge en verdi";
    }
    if (_startTime != null &&
        ((value.hour < _startTime.hour) ||
            value.hour == _startTime.hour &&
                value.minute <= _startTime.minute)) {
      return "Starttid må være mindre enn sluttid!";
    }
    return null;
  }

  void onSubmit() async {
    if (formKey.currentState.validate()) {
      _dialogService.showLoading();
      final DateTime startDateTime =
          DateUtils.fromTimeOfDay(_selectedDate, _startTime);

      final DateTime endDateTime =
          DateUtils.fromTimeOfDay(_selectedDate, _endTime);

      PickupPostForm form = PickupPostForm(startDateTime, endDateTime,
          _merknadController.text, _selectedStation.id);
      print(form.encode());
      CustomResponse response = await _pickupService.addPickup(form);
      _dialogService.hideLoading();
      if (!response.success) {
        print("rarara ${response.message}");
        _snackbarService.showSimpleSnackbar("Klarte ikke sende forespørsel");
        return;
      }
      _snackbarService.showSimpleSnackbar("Forespørsel sendt!");
    }
  }
}

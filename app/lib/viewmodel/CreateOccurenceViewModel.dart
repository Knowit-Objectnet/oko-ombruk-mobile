import 'package:flutter/material.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/routing/arguments/CalendarEventScreenArgs.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class CreateOccurenceViewModel extends BaseViewModel {
  IStationService _stationService;
  IPartnerService _partnerService;
  SnackbarService _snackbarService;
  final INavigatorService _navigatorService;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  List<Station> _stations = [];
  List<Station> get stations => _stations;

  List<Partner> _partners = [];
  List<Partner> get partners => _partners;

  Station _selectedStation;
  Partner _selectedPartner;
  Station get selectedStation => _selectedStation;
  Partner get selectedPartner => _selectedPartner;

  CreateOccurenceViewModel(
    this._stationService,
    this._partnerService,
    this._snackbarService,
    this._navigatorService,
  ) : super(state: ViewState.Busy);

  @override
  Future<void> init() async {
    await _fetchPartners();
    setState(ViewState.Idle);
  }

  Future<void> _fetchStations() async {
    await _stationService.fetchStations(StationGetForm()).then((response) {
      if (!response.success) {
        print(response.message);
        _snackbarService.showSimpleSnackbar("Klarte ikke hente stasjoner!");
      } else {
        _stations = response.data;
      }
    });
  }

  String pickerValidator(dynamic value) {
    if (value == null) return "Du må velge en verdi!";
    return null;
  }

  Future<void> _fetchPartners() async {
    await _partnerService.fetchPartners(PartnerGetForm()).then((response) {
      if (!response.success) {
        print(response.message);

        _snackbarService.showSimpleSnackbar("Klarte ikke hente partnere!");
      } else {
        _partners = response.data;
      }
    });
  }

  void onNextPressed() {
    if (_formKey.currentState.validate()) {
      _navigatorService.navigateTo(
        Routes.CreateCalendarEventView,
        arguments: CalendarEventScreenArgs(_selectedStation, _selectedPartner),
      );
    }
  }

  void onPartnerChanged(Partner partner) {
    _selectedPartner = partner;
    notifyListeners();
  }

  void onStationChanged(Station station) {
    _selectedStation = station;
    notifyListeners();
  }
}

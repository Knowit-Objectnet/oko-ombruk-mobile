import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class MessageViewModel extends BaseViewModel {
  final IStationService _stationService;
  final IPartnerService _partnerService;
  final SnackbarService _snackbarService;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  List<Station> _stations = List();
  List<Station> get stations => _stations;

  List<Partner> _partners = List();
  List<Partner> get partners => _partners;
  MessageViewModel(
    this._stationService,
    this._partnerService,
    this._snackbarService,
  ) : super(state: ViewState.Busy);

  @override
  Future<void> init() async {
    await _fetchPartners();
    setState(ViewState.Idle);
  }

  Station _selectedStation;
  Station get selectedStation => _selectedStation;

  Partner _selectedPartner;
  Partner get selectedPartner => _selectedPartner;

  TimeOfDay _startTime = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay get startTime => _startTime;

  TimeOfDay _endTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay get endTime => _endTime;

  void onTimeChanged(TimeType type, TimeOfDay value) {
    if (type == TimeType.Start) {
      _startTime = value;
    } else {
      _endTime = value;
    }
    notifyListeners();
  }

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

  void onPartnerChanged(Partner partner) {
    _selectedPartner = partner;
    notifyListeners();
  }

  void onStationChanged(Station station) {
    _selectedStation = station;
    notifyListeners();
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

  void submitForm() async {
    if (_formKey.currentState.validate()) {
      // TODO
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPatchForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class StationViewModel extends BaseViewModel {
  final IStationService _stationService;

  List<Station> _stations = [];

  StationViewModel(this._stationService) {
    fetchStations();
  }

  List<Station> get stations => _stations;

  Future<bool> fetchStations({int id}) async {
    StationGetForm form = StationGetForm(stationId: id);
    final CustomResponse<List<Station>> response =
        await _stationService.fetchStations(form);

    if (response.success) {
      _stations = response.data;
      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> addStation({
    @required String name,
    TimeOfDay openingTime,
    TimeOfDay closingTime,
  }) async {
    StationPostForm form = StationPostForm(name, openingTime, closingTime);
    final CustomResponse<Station> response =
        await _stationService.addStation(form);

    if (response.success) {
      _stations.add(response.data);
      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> updateStation({
    @required int id,
    String name,
    TimeOfDay openingTime,
    TimeOfDay closingTime,
  }) async {
    StationPatchForm form = StationPatchForm(
      stationId: id,
      name: name,
      openingTime: openingTime,
      closingTime: closingTime,
    );
    final CustomResponse<Station> response =
        await _stationService.updateStation(form);
    if (response.success) {
      final int index = stations.indexWhere((element) => element.id == id);
      _stations[index] = response.data;
      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> deleteStation({@required int id}) {
    assert(id != null);
    throw UnimplementedError();
  }
}

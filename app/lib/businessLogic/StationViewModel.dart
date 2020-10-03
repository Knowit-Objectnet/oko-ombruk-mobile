import 'package:flutter/material.dart';
import 'package:ombruk/businessLogic/Station.dart';
import 'package:ombruk/services/StationService.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';
import 'package:ombruk/services/serviceLocator.dart';

class StationViewModel extends ChangeNotifier {
  final StationService _stationService = serviceLocator<StationService>();

  List<Station> _stations = [];

  StationViewModel() {
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
    final CustomResponse<Station> response =
        await _stationService.updateStation(
      id: id,
      name: name,
      openingTime: openingTime,
      closingTime: closingTime,
    );
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

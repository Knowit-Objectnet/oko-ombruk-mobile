import 'package:flutter/material.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPatchForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';

abstract class IStationService {
  Future<CustomResponse<List<Station>>> fetchStations(
    StationGetForm form, {
    Function(CustomResponse<List<Station>>) newDataCallback,
  });

  Future<CustomResponse<Station>> addStation(StationPostForm form);

  Future<CustomResponse<Station>> updateStation(StationPatchForm form);

  Future<CustomResponse> deleteStation({@required int id});

  void updateDependencies(ICacheService cacheService);

  void removeCallback(Function function);
}

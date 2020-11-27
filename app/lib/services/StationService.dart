import 'package:flutter/material.dart';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPatchForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/services/mixins/ParseResponse.dart';

class StationService with ParseResponse implements IStationService {
  ICacheService _cacheService;
  StationService(this._cacheService);

  Future<CustomResponse<List<Station>>> fetchStations(
    StationGetForm form, {
    Function(CustomResponse<List<Station>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      path: ApiEndpoint.stations,
      form: form,
      parser: _parseResponse,
      newDataCallback: newDataCallback,
    );

    if (response.statusCode != 200) {
      return response;
    }
    return _parseResponse(response);
  }

  CustomResponse<List<Station>> _parseResponse(CustomResponse response) {
    return parseList<Station>(response, (station) => Station.fromJson(station));
  }

  Future<CustomResponse<Station>> addStation(StationPostForm form) async {
    CustomResponse response =
        await _cacheService.postRequest(ApiEndpoint.stations, form);
    if (!response.success) {
      return response;
    }
    return parseObject<Station>(
      response,
      (station) => Station.fromJson(station),
    );
  }

  Future<CustomResponse<Station>> updateStation(StationPatchForm form) async {
    CustomResponse response =
        await _cacheService.patchRequest(ApiEndpoint.stations, form);
    if (!response.success) {
      return response;
    }
    return parseObject<Station>(
      response,
      (station) => Station.fromJson(station),
    );
  }

  Future<CustomResponse> deleteStation({@required int id}) async {
    assert(id != null);

    throw UnimplementedError();
  }

  @override
  void updateDependencies(ICacheService cacheService) {
    this._cacheService = cacheService;
  }

  @override
  void removeCallback(Function function) {
    _cacheService.removeCallback(function, ApiEndpoint.stations);
  }
}

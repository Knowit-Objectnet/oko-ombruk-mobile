import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPatchForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';
import 'package:ombruk/services/interfaces/CacheService.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';

class StationService implements IStationService {
  IApi _api;
  CacheService _cacheService;
  StationService(this._api, this._cacheService);

  Future<CustomResponse<List<Station>>> fetchStations(
    StationGetForm form, {
    Function(CustomResponse<List<Station>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      form,
      ApiEndpoint.stations,
      newDataCallback: newDataCallback,
      parser: _parseResponse,
    );

    if (response.statusCode != 200) {
      return response;
    }
    return _parseResponse(response);
  }

  CustomResponse<List<Station>> _parseResponse(CustomResponse response) {
    try {
      List<Station> stations = List<dynamic>.from(jsonDecode(response.data))
          .map((json) => Station.fromJson(json))
          .toList();
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: stations,
      );
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: e.toString(),
      );
    }
  }

  Future<CustomResponse<Station>> addStation(StationPostForm form) async {
    CustomResponse response =
        await _cacheService.postRequest(ApiEndpoint.stations, form);

    if (response.statusCode == 200) {
      try {
        return CustomResponse<Station>(
          success: true,
          statusCode: response.statusCode,
          data: Station.fromJson(jsonDecode(response.data)),
        );
      } catch (error) {
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: 'Cannot parse body',
        );
      }
    }

    return response;
  }

  Future<CustomResponse<Station>> updateStation(StationPatchForm form) async {
    CustomResponse response =
        await _cacheService.patchRequest(ApiEndpoint.stations, form);

    if (response.statusCode == 200) {
      try {
        return CustomResponse<Station>(
          success: true,
          statusCode: response.statusCode,
          data: Station.fromJson(jsonDecode(response.data)),
        );
      } catch (e) {
        return CustomResponse<Station>(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: e.toString(),
        );
      }
    }

    return response;
  }

  Future<CustomResponse> deleteStation({@required int id}) async {
    assert(id != null);

    throw UnimplementedError();
  }

  @override
  void updateDependencies(IApi api, CacheService cacheService) {
    this._api = api;
    this._cacheService = cacheService;
  }

  @override
  void removeCallback(Function function) {
    _cacheService.removeCallback(function, ApiEndpoint.stations);
  }
}

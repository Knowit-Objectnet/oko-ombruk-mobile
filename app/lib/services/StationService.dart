import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ombruk/businessLogic/Station.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/Api.dart';

class StationService {
  final Api _api = Api();

  Future<CustomResponse<List<Station>>> fetchStations({int id}) async {
    Map<String, String> parameters = {};

    if (id != null) {
      parameters.putIfAbsent('stationId', () => id.toString());
    }

    CustomResponse response =
        await _api.getRequest(ApiEndpoint.stations, parameters);

    if (response.statusCode != 200) {
      return response;
    }

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

  Future<CustomResponse<Station>> addStation({
    @required String name,
    TimeOfDay openingTime,
    TimeOfDay closingTime,
  }) async {
    assert(name != null);

    Map<String, dynamic> bodyParameters = {'name': name};

    if (openingTime != null) {
      bodyParameters.putIfAbsent('openingTime', () => openingTime.toString());
    }
    if (closingTime != null) {
      bodyParameters.putIfAbsent('closingTime', () => closingTime.toString());
    }
    String body = jsonEncode(bodyParameters);

    CustomResponse response =
        await _api.postRequest(ApiEndpoint.stations, body);

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

  Future<CustomResponse<Station>> updateStation({
    @required int id,
    String name,
    TimeOfDay openingTime,
    TimeOfDay closingTime,
  }) async {
    assert(id != null);

    Map<String, dynamic> bodyParameters = {'id': id};
    if (name != null) {
      bodyParameters.putIfAbsent('name', () => name);
    }
    if (openingTime != null) {
      bodyParameters.putIfAbsent('openingTime', () => openingTime.toString());
    }
    if (closingTime != null) {
      bodyParameters.putIfAbsent('closingTime', () => closingTime.toString());
    }

    String body = jsonEncode(bodyParameters);

    CustomResponse response =
        await _api.patchRequest(ApiEndpoint.stations, body);

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
}

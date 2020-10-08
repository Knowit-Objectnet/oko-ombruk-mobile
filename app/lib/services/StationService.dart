import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/services/Api.dart';
import 'package:ombruk/services/forms/station/StationGetForm.dart';
import 'package:ombruk/services/forms/station/StationPatchForm.dart';
import 'package:ombruk/services/forms/station/StationPostForm.dart';

class StationService {
  final Api _api = Api();

  Future<CustomResponse<List<Station>>> fetchStations(
    StationGetForm form,
  ) async {
    CustomResponse response = await _api.getRequest(ApiEndpoint.stations, form);

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

  Future<CustomResponse<Station>> addStation(StationPostForm form) async {
    CustomResponse response =
        await _api.postRequest(ApiEndpoint.stations, form);

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
        await _api.patchRequest(ApiEndpoint.stations, form);

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

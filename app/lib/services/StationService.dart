import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/businessLogic/Station.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/globals.dart' as globals;

class StationService {
  final UserViewModel _userViewModel = serviceLocator<UserViewModel>();

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  void _updateTokenInHeader() {
    final String token = 'Bearer ' + (_userViewModel?.accessToken ?? '');
    if (_headers.containsKey('Authorization')) {
      _headers.update('Authorization', (value) => token);
    } else {
      _headers.putIfAbsent('Authorization', () => token);
    }
  }

  Future<CustomResponse<List<Station>>> fetchStations({int id}) async {
    Map<String, String> parameters = {};

    if (id != null) {
      parameters.putIfAbsent('stationId', () => id.toString());
    }

    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/stations');

    final Response response = await get(uri, headers: _headers);

    if (response.statusCode != 200) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: response.body,
      );
    }

    try {
      List<Station> stations = [];
      final List<dynamic> parsed = jsonDecode(response.body);
      for (var element in parsed) {
        stations.add(Station.fromJson(element));
      }
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

    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/stations');

    Map<String, dynamic> bodyParameters = {'name': name};

    if (openingTime != null) {
      bodyParameters.putIfAbsent('openingTime', () => openingTime.toString());
    }
    if (closingTime != null) {
      bodyParameters.putIfAbsent('closingTime', () => closingTime.toString());
    }
    String body = jsonEncode(bodyParameters);

    Response response = await post(uri, headers: _headers, body: body);

    // REG authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await post(uri, headers: _headers, body: body);
      } else {
        // Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
      }
    }

    if (response.statusCode == 200) {
      final int id = int.tryParse(response.body);
      if (id == null) {
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: 'Cannot parse ID to integer. ID was $id',
        );
      }
      return CustomResponse<Station>(
        success: true,
        statusCode: response.statusCode,
        data: Station(id, name, openingTime, closingTime),
      );
    }

    return CustomResponse(
      success: false,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }

  Future<CustomResponse<Station>> updateStation({
    @required int id,
    String name,
    TimeOfDay openingTime,
    TimeOfDay closingTime,
  }) async {
    assert(id != null);

    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/stations');

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

    Response response = await post(uri, headers: _headers, body: body);

    // REG authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await post(uri, headers: _headers, body: body);
      } else {
        // Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
      }
    }

    if (response.statusCode == 200) {
      try {
        final dynamic parsed = jsonDecode(response.body);
        Station station = Station.fromJson(parsed);
        return CustomResponse<Station>(
          success: true,
          statusCode: response.statusCode,
          data: station,
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

    return CustomResponse(
      success: false,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }

  Future<CustomResponse> deleteStation({@required int id}) async {
    assert(id != null);
    _updateTokenInHeader();

    throw UnimplementedError();
  }
}

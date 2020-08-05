import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/globals.dart' as globals;

class PickupService {
  UserViewModel _userViewModel = serviceLocator<UserViewModel>();

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

  Future<CustomResponse> addPickup({
    @required DateTime startDateTime,
    @required DateTime endDateTime,
    @required String description,
    @required int stationId,
  }) async {
    _updateTokenInHeader();

    final Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/pickups');

    String body = jsonEncode({
      'startDateTime': globals.getDateString(startDateTime),
      'endDateTime': globals.getDateString(endDateTime),
      'description': description,
      'stationId': stationId,
    });

    Response response = await post(uri, headers: _headers, body: body);

    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await post(uri, headers: _headers, body: body);
      } else {
        // TODO: Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
        );
      }
    }

    return CustomResponse(
      success: response.statusCode == 200,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }
}

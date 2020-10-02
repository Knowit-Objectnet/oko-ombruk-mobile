import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/services/Api.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/globals.dart' as globals;

class PickupService {
  Api _api = Api();

  Future<CustomResponse> addPickup({
    @required DateTime startDateTime,
    @required DateTime endDateTime,
    @required String description,
    @required int stationId,
  }) async {
    String body = jsonEncode({
      'startDateTime': globals.getDateString(startDateTime),
      'endDateTime': globals.getDateString(endDateTime),
      'description': description,
      'stationId': stationId,
    });

    CustomResponse response =
        await _api.postRequest(ApiEndpoint.requests, body);

    //no logic to be found here... TODO
    return response;
  }
}

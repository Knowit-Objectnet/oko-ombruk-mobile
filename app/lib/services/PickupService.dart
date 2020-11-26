import 'dart:convert';

import 'package:ombruk/const/ApiEndpoint.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/pickup/PickupGetForm.dart';
import 'package:ombruk/services/forms/pickup/PickupDeleteForm.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/forms/pickup/PickupUpdateForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';

class PickupService implements IPickupService {
  final IApi _api;
  PickupService(this._api);

  Future<CustomResponse> addPickup(PickupPostForm form) async =>
      await _api.postRequest(ApiEndpoint.requests, form);

  @override
  Future<CustomResponse> deletePickup(PickupDeleteForm form) {
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<List<Pickup>>> fetchPickups(PickupGetForm form) async {
    CustomResponse response =
        await _api.getRequest(path: ApiEndpoint.pickups, form: form);
    if (!response.success) return response;

    try {
      List<Pickup> pickups = List<dynamic>.from(jsonDecode(response.data))
          .map((pickup) => Pickup.fromJson(pickup))
          .toList();
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: pickups,
      );
    } catch (e) {
      print(e.toString());
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: e.toString(),
      );
    }
  }

  @override
  Future<CustomResponse<Pickup>> updatePickup(PickupUpdateForm form) async {
    CustomResponse response =
        await _api.patchRequest(ApiEndpoint.pickups, form);
    if (!response.success) return response;

    try {
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: Pickup.fromJson(jsonDecode(response.data)),
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
}

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/pickup/PickupGetForm.dart';
import 'package:ombruk/services/forms/pickup/PickupDeleteForm.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/forms/pickup/PickupUpdateForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';
import 'package:ombruk/services/mixins/ParseResponse.dart';

class PickupService with ParseResponse implements IPickupService {
  ICacheService _cacheService;
  PickupService(this._cacheService);

  Future<CustomResponse> addPickup(PickupPostForm form) async =>
      await _cacheService.postRequest(ApiEndpoint.requests, form);

  @override
  Future<CustomResponse> deletePickup(PickupDeleteForm form) {
    throw UnimplementedError();
  }

  @override
  Future<CustomResponse<List<Pickup>>> fetchPickups(
    PickupGetForm form, {
    Function(CustomResponse<List<Pickup>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      path: ApiEndpoint.pickups,
      form: form,
      parser: _parseResponse,
      newDataCallback: newDataCallback,
    );
    return response.success ? _parseResponse(response) : response;
  }

  CustomResponse<List<Pickup>> _parseResponse(CustomResponse response) {
    return parseList<Pickup>(response, (pickup) => Pickup.fromJson(pickup));
  }

  @override
  Future<CustomResponse<Pickup>> updatePickup(PickupUpdateForm form) async {
    CustomResponse response =
        await _cacheService.patchRequest(ApiEndpoint.pickups, form);
    return response.success
        ? parseObject<Pickup>(response, (pickup) => Pickup.fromJson(pickup))
        : response;
  }

  @override
  void updateDependencies(ICacheService cacheService) {
    _cacheService = cacheService;
  }
}

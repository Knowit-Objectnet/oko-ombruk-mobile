import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/services/Api.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';

class PickupService implements IPickupService{
  final IApi _api;
  PickupService(this._api);

  Future<CustomResponse> addPickup(PickupPostForm form) async =>
      await _api.postRequest(ApiEndpoint.requests, form);
}

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/services/Api.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';

class PickupService {
  Api _api = Api();

  Future<CustomResponse> addPickup(PickupPostForm form) async {
    CustomResponse response =
        await _api.postRequest(ApiEndpoint.requests, form);

    //no logic to be found here... TODO
    return response;
  }
}

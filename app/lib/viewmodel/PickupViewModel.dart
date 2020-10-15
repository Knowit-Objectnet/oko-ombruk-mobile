import 'package:flutter/material.dart';

import 'package:ombruk/services/PickupService.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class PickupViewModel extends BaseViewModel {
  final PickupService _pickupService;
  PickupViewModel(this._pickupService);

  Future<bool> addPickup({
    @required DateTime startDateTime,
    @required DateTime endDateTime,
    @required String description,
    @required int stationId,
  }) async {
    PickupPostForm form =
        PickupPostForm(startDateTime, endDateTime, description, stationId);
    final CustomResponse response = await _pickupService.addPickup(form);

    if (response.success) {
      return true;
    } else {
      print(response);
      return false;
    }
  }
}

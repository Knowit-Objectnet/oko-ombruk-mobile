import 'package:flutter/material.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class PickupViewModel extends BaseViewModel {
  final IPickupService _pickupService;
  PickupViewModel(this._pickupService);

  @override
  Future<void> init() {}

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

import 'package:flutter/material.dart';

import 'package:ombruk/services/PickupService.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/models/CustomResponse.dart';

class PickupViewModel extends ChangeNotifier {
  final PickupService _pikcupService = serviceLocator<PickupService>();

  Future<bool> addPickup({
    @required DateTime startDateTime,
    @required DateTime endDateTime,
    @required String description,
    @required int stationId,
  }) async {
    PickupPostForm form =
        PickupPostForm(startDateTime, endDateTime, description, stationId);
    final CustomResponse response = await _pikcupService.addPickup(form);

    if (response.success) {
      return true;
    } else {
      print(response);
      return false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class StationPatchForm implements IForm {
  final int stationId;
  final String name;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  StationPatchForm({
    @required this.stationId,
    this.name,
    this.openingTime,
    this.closingTime,
  }) {
    if (!validate()) {
      throw Exception("Failed to validate StationPatchForm");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.stationPatchId: stationId,
        if (name != null) ApiParameters.stationPatchName: name,
        if (openingTime != null)
          ApiParameters.stationPatchOpeningTime: openingTime.toString(),
        if (closingTime != null)
          ApiParameters.stationPatchClosingTime: closingTime.toString(),
      };

  @override
  bool validate() {
    if (closingTime.hour <= openingTime.hour &&
        closingTime.minute < openingTime.minute) {
      return false;
    }
    return true;
  }
}

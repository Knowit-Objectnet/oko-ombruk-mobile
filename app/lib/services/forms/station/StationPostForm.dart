import 'package:flutter/material.dart';
import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class StationPostForm implements IForm {
  final String name;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;
  StationPostForm(this.name, this.openingTime, this.closingTime) {
    if (!validate()) {
      throw Exception("Failed to validate StationPostForm");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.stationName: name,
        ApiParameters.openingTime: openingTime.toString(),
        ApiParameters.closingTime: closingTime.toString(),
      };

  @override
  bool validate() {
    return true;
  }
}

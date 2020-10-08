import 'package:flutter/foundation.dart';
import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class PartnerPatchForm implements IForm {
  final int partnerId;
  final String name;
  final String description;
  final String phone;
  final String email;
  PartnerPatchForm(
      {@required this.partnerId,
      this.name,
      this.description,
      this.phone,
      this.email}) {
    if (!validate()) {
      throw Exception("Failed to validate PartnerDeleteForm");
    }
  }

  @override
  Map<String, String> encode() => {
        ApiParameters.partnerId: partnerId.toString(),
        if (name != null) ApiParameters.parterName: name,
        if (description != null) ApiParameters.partnerDescription: description,
        if (phone != null) ApiParameters.partnerPhone: phone,
        if (email != null) ApiParameters.partnerMail: email
      };

  @override
  bool validate() {
    if (partnerId == null || partnerId < 1) {
      return false;
    }
    return true;
  }
}

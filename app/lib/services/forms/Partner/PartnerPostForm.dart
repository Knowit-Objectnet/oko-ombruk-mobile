import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class PartnerPostForm implements IForm {
  final String name;
  final String description;
  final String phone;
  final String email;
  PartnerPostForm(this.name, this.description, this.phone, this.email) {
    if (!validate()) {
      throw Exception("PartnerPostForm validation failed");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.parterName: name,
        ApiParameters.partnerDescription: description,
        ApiParameters.partnerPhone: phone,
        ApiParameters.partnerMail: email,
      };

  @override
  bool validate() {
    return true;
  }
}

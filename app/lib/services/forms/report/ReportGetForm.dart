import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class ReportGetForm implements IForm {
  final int partnerId;
  ReportGetForm({this.partnerId}) {
    if (!validate()) {
      throw Exception("Failed to validate ReportGetForm");
    }
  }
  @override
  Map<String, String> encode() => {
        if (partnerId != null) ApiParameters.partnerId: partnerId.toString(),
      };

  @override
  bool validate() {
    if (partnerId != null) {
      if (partnerId <= 0) {
        return false;
      }
    }
    return true;
  }
}

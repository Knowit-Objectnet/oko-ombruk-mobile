import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class PartnerGetForm extends IForm {
  final int stationId;
  PartnerGetForm({this.stationId}) {
    if (!validate()) {
      throw Exception("Failed to validate ReportGetForm");
    }
  }

  @override
  Map<String, String> encode() => {
        if (stationId != null) ApiParameters.stationId: stationId.toString(),
      };

  @override
  bool validate() {
    if (stationId != null) {
      if (stationId <= 0) return false;
    }
    return true;
  }
}

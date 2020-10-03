import 'package:ombruk/services/forms/IForm.dart';

class EventGetForm implements IForm {
  int stationId;
  int partnerId;
  EventGetForm({this.stationId, this.partnerId}) {
    if (!validate()) {
      throw Exception("Invalid data in EventGetForm");
    }
  }

  @override
  Map<String, String> encode() => {
        if (stationId != null) 'stationId': stationId.toString(),
        if (partnerId != null) 'partnerId': partnerId.toString(),
      };

  @override
  bool validate() {
    if (stationId != null) {
      if (stationId <= 0) return false;
    }
    if (partnerId != null) {
      if (partnerId <= 0) return false;
    }
    return true;
  }
}

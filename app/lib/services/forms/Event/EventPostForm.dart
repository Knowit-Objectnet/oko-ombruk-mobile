import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/globals.dart' as globals;

class EventPostForm extends IForm {
  DateTime startDateTime;
  DateTime endDateTime;
  int stationId;
  int partnerId;

  EventPostForm(
    this.startDateTime,
    this.endDateTime,
    this.stationId,
    this.partnerId,
  ) {
    if (!validate()) {
      throw Exception("Failed to validate EventPostForm");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.eventStartDateTime: globals.getDateString(startDateTime),
        ApiParameters.eventEndDateTime: globals.getDateString(endDateTime),
        ApiParameters.stationId: stationId,
        ApiParameters.partnerId: partnerId,
      };

  @override
  bool validate() {
    return true;
  }
}

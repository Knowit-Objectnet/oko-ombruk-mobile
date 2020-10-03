import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/globals.dart' as globals;

class PickupPostForm implements IForm {
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String description;
  final int stationId;
  PickupPostForm(
      this.startDateTime, this.endDateTime, this.description, this.stationId) {
    if (!validate()) {
      throw Exception("Failed to validate PickupPostForm");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.pickupStartDateTime: globals.getDateString(startDateTime),
        ApiParameters.pickupEndDateTime: globals.getDateString(endDateTime),
        ApiParameters.pickupDescription: description,
        ApiParameters.pickupStationId: stationId,
      };

  @override
  bool validate() {
    return true;
  }
}

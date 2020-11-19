import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/utils/DateUtils.dart';

class PickupGetForm implements IForm {
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int partnerId;
  final int stationId;

  PickupGetForm({
    this.startDateTime,
    this.endDateTime,
    this.partnerId,
    this.stationId,
  });
  @override
  Map<String, String> encode() => {
        if (startDateTime != null)
          ApiParameters.pickupStartDateTime:
              DateUtils.getDateString(startDateTime),
        if (endDateTime != null)
          ApiParameters.pickupEndDateTime: DateUtils.getDateString(endDateTime),
        if (stationId != null)
          ApiParameters.pickupStationId: stationId.toString(),
        if (partnerId != null) "partnerId": partnerId.toString(),
      };

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}

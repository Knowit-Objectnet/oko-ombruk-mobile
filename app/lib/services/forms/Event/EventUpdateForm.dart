import 'package:flutter/foundation.dart';
import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/utils/DateUtils.dart';

class EventUpdateForm implements IForm {
  final int eventId;
  final DateTime startDateTime;
  final DateTime endDateTime;
  EventUpdateForm(
      {@required this.eventId, this.startDateTime, this.endDateTime}) {
    if (!validate()) {
      throw Exception("Failed to validate EventUpdateForm");
    }
  }

  @override
  Map<String, dynamic> encode() => {
        ApiParameters.eventUpdateId: eventId,
        if (startDateTime != null)
          ApiParameters.eventStartDateTime:
              DateUtils.getDateString(startDateTime),
        if (endDateTime != null)
          ApiParameters.eventEndDateTime: DateUtils.getDateString(endDateTime),
      };

  @override
  bool validate() {
    if (eventId == null || eventId < 1) {
      return false;
    }
    if (startDateTime != null &&
        endDateTime != null &&
        startDateTime.millisecondsSinceEpoch >=
            endDateTime.millisecondsSinceEpoch) {
      return false;
    }
    return true;
  }
}

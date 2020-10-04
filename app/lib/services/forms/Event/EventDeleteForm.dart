import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/utils/DateUtils.dart';

class EventDeleteForm implements IForm {
  final int eventId;
  final int recurrenceRuleId;
  final DateTime startDateTime;
  final DateTime endDateTime;
  EventDeleteForm({
    this.eventId,
    this.recurrenceRuleId,
    this.startDateTime,
    this.endDateTime,
  }) {
    if (!validate()) {
      throw Exception("Failed to validate EventDeleteForm");
    }
  }
  @override
  Map<String, String> encode() => {
        if (eventId != null)
          ApiParameters.eventDeleteEventId: eventId.toString(),
        if (recurrenceRuleId != null)
          ApiParameters.recurrenceRuleId: recurrenceRuleId.toString(),
        if (startDateTime != null)
          ApiParameters.eventStartDateTime:
              DateUtils.getDateString(startDateTime),
        if (endDateTime != null)
          ApiParameters.eventEndDateTime: DateUtils.getDateString(endDateTime),
      };

  @override
  bool validate() {
    if (startDateTime != null &&
        endDateTime != null &&
        startDateTime.millisecondsSinceEpoch <=
            endDateTime.millisecondsSinceEpoch) {
      return false;
    }
    return true;
  }
}

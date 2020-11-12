import 'package:flutter/foundation.dart';
import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/utils/DateUtils.dart';

class EventPostForm extends IForm {
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int stationId;
  final int partnerId;
  RecurrenceRule recurrenceRule;

  EventPostForm(
    this.startDateTime,
    this.endDateTime,
    this.stationId,
    this.partnerId,
    this.recurrenceRule,
  ) {
    if (!validate()) {
      throw Exception("Failed to validate EventPostForm");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.eventStartDateTime:
            DateUtils.getDateString(startDateTime),
        ApiParameters.eventEndDateTime: DateUtils.getDateString(endDateTime),
        ApiParameters.stationId: stationId,
        ApiParameters.partnerId: partnerId,
        ApiParameters.eventRecurrenceRule:
            recurrenceRule != null ? recurrenceRule.encode() : null,
      };

  @override
  bool validate() {
    return true;
  }
}

class RecurrenceRule implements IForm {
  final List<Weekdays> days;
  final DateTime until;
  final int interval;
  final int count;
  RecurrenceRule({
    this.days,
    this.until,
    this.interval,
    this.count,
  });

  @override
  Map<String, dynamic> encode() => {
        if (days != null)
          'days': days.map((e) => describeEnum(e).toUpperCase()).toList(),
        if (until != null) 'until': DateUtils.getDateString(until) + "Z",
        if (interval != null) 'interval': interval,
        if (count != null) 'count': count,
      };

  @override
  bool validate() {
    return true;
  }
}

abstract class ApiParameters {
  static const String stationId = "stationId";
  static const String partnerId = "partnerId";

  static const String parterName = "name";
  static const String partnerDescription = "description";
  static const String partnerPhone = "phone";
  static const String partnerMail = "email";

  static const String pickupStartDateTime = "startDateTime";
  static const String pickupEndDateTime = "endDateTime";
  static const String pickupDescription = "description";
  static const String pickupStationId = "stationId";

  static const String stationName = "name";
  //these are wrong and should be refactored, but just proof of concept for now.
  static const String openingTime = "openingTime";
  static const String closingTime = "closingTime";

  static const String eventStartDateTime = "startDateTime";
  static const String eventEndDateTime = "endDateTime";
  static const String eventStationId = "stationId";
  static const String eventPartnerId = "partnerId";

  static const String recurrenceRule = "recurrenceRule";
  static const String recurrenceRuleUntil = "until";
  static const String recurrenceRuleDays = "days";
  static const String recurrenceRuleInterval = "interval";
}

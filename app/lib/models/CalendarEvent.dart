import 'package:ombruk/globals.dart' as globals;

class CalendarEvent {
  final int id;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int stationID;
  final int partnerID;
  final _Station station;
  final _Partner partner;
  final _RecurrenceRule recurrenceRule;

  CalendarEvent(this.id, this.startDateTime, this.endDateTime, this.stationID,
      this.partnerID, this.station, this.partner, this.recurrenceRule);

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    DateTime startDate;
    DateTime endDate;
    try {
      startDate = DateTime.parse(json['startDateTime']);
      endDate = DateTime.parse(json['endDateTime']);
    } catch (_) {
      throw Exception("Invalid DateTime format in CalendarEvent");
    }

    _RecurrenceRule recurrenceRule;
    if (json['recurrenceRule'] != null) {
      recurrenceRule = _RecurrenceRule.fromJson(json['recurrenceRule']);
    }

    return CalendarEvent(
      json['id'],
      startDate,
      endDate,
      json['stationID'],
      json['partnerID'],
      _Station.fromJson(json['station']),
      _Partner.fromJson(json['partner']),
      recurrenceRule,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        // substring removes milliseconds
        'startDateTime': globals.getDateString(startDateTime),
        'endDateTime': globals.getDateString(endDateTime),
        'stationID': stationID,
        'partnerID': partnerID,
        'station': station.toJson(),
        'partner': partner.toJson(),
        'recurrenceRule':
            recurrenceRule != null ? recurrenceRule.toJson() : null
      };
}

class _Station {
  final int id;
  final String name;

  _Station.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class _Partner {
  final int id;
  final String name;

  _Partner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class _RecurrenceRule {
  final int id;

  _RecurrenceRule.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
      };
}

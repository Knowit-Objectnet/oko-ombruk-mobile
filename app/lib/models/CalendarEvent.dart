import 'package:ombruk/models/Station.dart';

class CalendarEvent {
  final int id;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final Station station;
  final _Partner partner;
  final _RecurrenceRule recurrenceRule;

  CalendarEvent(
    this.id,
    this.startDateTime,
    this.endDateTime,
    this.station,
    this.partner,
    this.recurrenceRule,
  );

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
      Station.fromJson(json["station"]),
      _Partner.fromJson(json['partner']),
      recurrenceRule,
    );
  }

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       // substring removes milliseconds
  //       'startDateTime': DateUtils.getDateString(startDateTime),
  //       'endDateTime': DateUtils.getDateString(endDateTime),
  //       'station': station.toJson(),
  //       'partner': partner.toJson(),
  //       'recurrenceRule':
  //           recurrenceRule != null ? recurrenceRule.toJson() : null
  //     };

  // @override
  // String toString() {
  //   return toJson().toString();
  // }
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

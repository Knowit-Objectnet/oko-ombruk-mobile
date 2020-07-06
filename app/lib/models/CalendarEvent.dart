class CalendarEvent {
  final int id;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int stationID;
  final int partnerID;
  final _Station station;
  final _Partner partner;

  CalendarEvent(this.id, this.startDateTime, this.endDateTime, this.stationID,
      this.partnerID, this.station, this.partner);

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    DateTime startDate;
    DateTime endDate;
    try {
      startDate = DateTime.parse(json['startDateTime']);
      endDate = DateTime.parse(json['endDateTime']);
    } catch (_) {
      throw Exception("Invalid DateTime format in CalendarEvent");
    }
    return CalendarEvent(
      json['id'],
      startDate,
      endDate,
      json['stationID'],
      json['partnerID'],
      _Station.fromJson(json['station']),
      _Partner.fromJson(json['partner']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        // substring removes milliseconds
        'startDateTime': startDateTime
            .toIso8601String()
            .substring(0, startDateTime.toString().length - 4),
        'endDateTime': endDateTime
            .toIso8601String()
            .substring(0, startDateTime.toString().length - 4),
        'stationID': stationID,
        'partnerID': partnerID,
        'station': station.toJson(),
        'partner': partner.toJson()
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

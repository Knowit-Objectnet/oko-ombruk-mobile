import 'package:ombruk/globals.dart' as globals;

class WeightReport {
  final int reportID;
  final _Event event;
  final _Partner partner;
  final int weight;
  final DateTime createdDateTime;

  WeightReport(this.reportID, this.event, this.partner, this.weight,
      this.createdDateTime);

  factory WeightReport.fromJson(Map<String, dynamic> json) {
    DateTime createdDateTime;
    try {
      createdDateTime = DateTime.parse(json['createdDateTime']);
    } catch (_) {
      throw Exception("Invalid DateTime format in WeightReport");
    }
    return WeightReport(
      json['reportID'],
      _Event.fromJson(json['event']),
      _Partner.fromJson(json['partner']),
      json['weight'],
      createdDateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'reportID': reportID,
        'event': event.toJson(),
        'partner': partner.toJson(),
        'weight': weight,
        'createdDateTime': globals.getDateString(createdDateTime)
      };
}

class _Event {
  final int id;

  _Event.fromJson(Map<String, dynamic> json) : id = json['id'];

  Map<String, dynamic> toJson() => {'id': id};
}

class _Partner {
  final int id;
  final String name;

  _Partner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

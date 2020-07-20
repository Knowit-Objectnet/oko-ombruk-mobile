import 'package:ombruk/globals.dart' as globals;

class WeightEvent {
  final int reportID;
  final _Partner partner;
  final int weight;
  final DateTime createdDateTime;

  WeightEvent(this.reportID, this.partner, this.weight, this.createdDateTime);

  factory WeightEvent.fromJson(Map<String, dynamic> json) {
    DateTime createdDateTime;
    try {
      createdDateTime = DateTime.parse(json['createdDateTime']);
    } catch (_) {
      throw Exception("Invalid DateTime format in WeightEvent");
    }
    return WeightEvent(
      json['reportID'],
      _Partner.fromJson(json['partner']),
      json['weight']?.toDouble(),
      createdDateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'reportID': reportID,
        'partner': partner.toJson(),
        'weight': weight,
        'createdDateTime': globals.getDateString(createdDateTime)
      };
}

class _Partner {
  final int id;
  final String name;

  _Partner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

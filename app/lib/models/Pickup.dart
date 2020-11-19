import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/utils/DateUtils.dart';

class Pickup {
  int id;
  DateTime startDateTime;
  DateTime endDateTime;
  String description;
  Station station;
  Partner chosenPartner;
  List<Request> requests = [];

  Pickup(
    this.id,
    this.startDateTime,
    this.endDateTime,
    this.description,
    this.station, {
    this.chosenPartner,
  });

  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      json["id"],
      DateTime.parse(json["startDateTime"]),
      DateTime.parse(json["endDateTime"]),
      json["description"],
      Station.fromJson(json["station"]),
      chosenPartner: json["chosenPartner"] == null
          ? null
          : Partner.fromJson(json["chosenPartner"]),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'startDateTime': DateUtils.getDateString(startDateTime),
        'endDateTime': DateUtils.getDateString(endDateTime),
        'description': description,
        'station': station.id,
        if (chosenPartner != null) 'partner': chosenPartner.id,
      };
}

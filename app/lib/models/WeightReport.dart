import 'package:ombruk/utils/DateUtils.dart';

class WeightReport {
  final int reportID;
  final int eventID;
  final int partnerID;
  final _Station station;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final DateTime reportedDateTime;
  int weight;

  WeightReport(
    this.reportID,
    this.eventID,
    this.partnerID,
    this.station,
    this.startDateTime,
    this.endDateTime,
    this.weight,
    this.reportedDateTime,
  );

  factory WeightReport.fromJson(Map<String, dynamic> json) {
    DateTime startDateTime;
    DateTime endDateTime;
    DateTime reportedDateTime;
    if (json['startDateTime'] != null) {
      try {
        startDateTime = DateTime.parse(json['startDateTime']);
      } catch (e) {
        throw Exception("Invalid startDateTime format in WeightReport");
      }
    }
    if (json['endDateTime'] != null) {
      try {
        endDateTime = DateTime.parse(json['endDateTime']);
      } catch (e) {
        throw Exception("Invalid endDateTime format in WeightReport");
      }
    }
    if (json['reportedDateTime'] != null) {
      try {
        reportedDateTime = DateTime.parse(json['reportedDateTime']);
      } catch (e) {
        throw Exception("Invalid reportedDateTime format in WeightReport");
      }
    }

    return WeightReport(
      json['reportID'],
      json['eventID'],
      json['partnerID'],
      _Station.fromJson(json['station']),
      startDateTime,
      endDateTime,
      json['weight'],
      reportedDateTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'reportID': reportID,
        'eventID': eventID,
        'partnerID': partnerID,
        'station': station.toJson(),
        'startDateTime': DateUtils.getDateString(startDateTime),
        'endDateTime': DateUtils.getDateString(endDateTime),
        'weight': weight,
        'reportedDateTime': DateUtils.getDateString(reportedDateTime),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class _Station {
  final int id;
  final String name;

  _Station.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

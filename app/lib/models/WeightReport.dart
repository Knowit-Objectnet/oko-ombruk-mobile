import 'package:ombruk/globals.dart' as globals;

class WeightReport {
  final int reportID;
  final int eventID;
  final int partnerID;
  final int stationID;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final int weight;
  final DateTime reportedDateTime;

  WeightReport(
    this.reportID,
    this.eventID,
    this.partnerID,
    this.stationID,
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
      json['stationID'],
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
        'stationID': stationID,
        'startDateTime': globals.getDateString(startDateTime),
        'endDateTime': globals.getDateString(endDateTime),
        'weight': weight,
        'reportedDateTime': globals.getDateString(reportedDateTime),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

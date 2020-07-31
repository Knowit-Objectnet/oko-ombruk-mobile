import 'package:test/test.dart';
import 'package:ombruk/models/WeightReport.dart';

void main() {
  final parsedJson = {
    "reportID": 1,
    "eventID": 1,
    "partnerID": 2,
    "stationID": 1,
    "startDateTime": "2020-07-31T08:00:00",
    "endDateTime": "2020-07-31T09:00:00",
    "weight": null,
    "reportedDateTime": null
  };

  final jsonFromApi = {
    "reportID": 1,
    "eventID": 1,
    "partnerID": 2,
    "stationID": 1,
    "startDateTime": "2020-07-31T08:00:00Z",
    "endDateTime": "2020-07-31T09:00:00Z",
    "weight": null,
    "reportedDateTime": null
  };

  final jsonFromApiScrambled = {
    "reportedDateTime": null,
    "reportID": 1,
    "eventID": 1,
    "startDateTime": "2020-07-31T08:00:00Z",
    "partnerID": 2,
    "endDateTime": "2020-07-31T09:00:00Z",
    "weight": null,
    "stationID": 1,
  };

  final invalidJsonFromApi = {
    "reportedDateTime": null,
    "reportID": 2,
    "eventID": 1,
    "startDateTime": "20-07-31 08:00Z",
    "partnerID": 2,
    "endDateTime": "20-07-31T09:00:00Z",
    "weight": null,
    "stationID": 1,
  };

  test('Test correct JSON parsing', () {
    expect(WeightReport.fromJson(jsonFromApi).toJson(), parsedJson);
  });

  test('Test correct JSON parsing', () {
    expect(WeightReport.fromJson(jsonFromApiScrambled).toJson(), parsedJson);
  });

  test('Test invalid JSON parsing', () {
    expect(() => WeightReport.fromJson(invalidJsonFromApi), throwsException);
  });
}

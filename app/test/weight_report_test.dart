import 'package:test/test.dart';
import 'package:ombruk/models/WeightReport.dart';

void main() {
  final correctJson = {
    "reportID": 1,
    "event": {"id": 8},
    "partner": {"id": 1, "name": ""},
    "weight": 5,
    "createdDateTime": "2020-07-27T10:17:14"
  };

  final validJsonLongTime = {
    "reportID": 1,
    "event": {"id": 8},
    "partner": {"id": 1, "name": ""},
    "weight": 5,
    "createdDateTime": "2020-07-27T10:17:14.53"
  };

  final validJsonScrambled = {
    "partner": {"id": 1, "name": ""},
    "reportID": 1,
    "weight": 5,
    "createdDateTime": "2020-07-27T10:17:14.53",
    "event": {"id": 8}
  };

  final invalidJson = {
    "reportId": 1,
    "event": {"id": 8},
    "partner": {"id": 1, "name": ""},
    "weight": 5.1,
    "createdDateTime": "2020-07-2 T10:17:14.53"
  };

  test('Test correct JSON parsing', () {
    expect(WeightReport.fromJson(validJsonLongTime).toJson(), correctJson);
  });

  test('Test correct JSON parsing', () {
    expect(WeightReport.fromJson(validJsonScrambled).toJson(), correctJson);
  });

  test('Test invalid JSON parsing', () {
    expect(() => WeightReport.fromJson(invalidJson), throwsException);
  });
}

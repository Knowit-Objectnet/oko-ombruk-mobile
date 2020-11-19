import 'package:test/test.dart';
import 'package:ombruk/models/CalendarEvent.dart';

void main() {
  final validJson = {
    "id": 1,
    "startDateTime": "2020-07-02T12:17:39",
    "endDateTime": "2020-07-02T13:17:39",
    "station": {"id": 1, "name": ""},
    "partner": {"id": 2, "name": ""},
    "recurrenceRule": null
  };

  final invalidDateJson = {
    "id": 1,
    "startDateTime": "20-07-02T12:17:39",
    "endDateTime": "20-07-02T13:17:39",
    "station": {"id": 1, "name": ""},
    "partner": {"id": 2, "name": ""}
  };

  // test('Test correct JSON parsing', () {
  //   expect(CalendarEvent.fromJson(validJson).toJson(), validJson);
  // });

  test('Test invalid JSON parsing', () {
    expect(() => CalendarEvent.fromJson(invalidDateJson), throwsException);
  });
}

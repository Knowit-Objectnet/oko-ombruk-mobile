import 'package:flutter/material.dart';
import 'package:ombruk/models/OpeningHours.dart';
import 'package:ombruk/utils/DateUtils.dart';

class Station {
  final int id;
  final String name;
  final Map<int, OpeningHours> hours;

  Station(
    this.id,
    this.name,
    this.hours,
  );

  factory Station.fromJson(Map<String, dynamic> json) {
    Map<int, OpeningHours> hours = Map();
    try {
      /// Takes a String input, for example '11:23:20Z', and returns a [TimeOfDay]
      TimeOfDay _toTime(String value) {
        List<String> timeSplitted = value.split(':');
        int hour = int.tryParse(timeSplitted[0]);
        int minute = int.tryParse(timeSplitted[1]);
        if (hour == null || minute == null) {
          throw Exception(
              'Invalid time format in Partner, tried to parse $value');
        }
        return TimeOfDay(hour: hour, minute: minute);
      }

      Map<String, dynamic>.from(json['hours']).entries.forEach((entry) {
        List<String> tempTime = List<String>.from(entry.value);
        hours.putIfAbsent(DateUtils.jsonWeekdays[entry.key],
            () => OpeningHours(_toTime(tempTime[0]), _toTime(tempTime[1])));
      });
    } catch (e) {
      throw Exception('Failed to convert json $e');
    }

    return Station(
      json['id'],
      json['name'],
      hours,
    );
  }

  Map<String, dynamic> _toJson() => {
        'id': id,
        'name': name,
        'hours': Map<String, List<String>>.fromIterable(
          hours.entries,
          key: (entry) => DateUtils.jsonWeekdays.keys.firstWhere(
              (element) => DateUtils.jsonWeekdays[element] == entry.key),
          value: (entry) => [
            DateUtils.timeOfDayToString(entry.value.opensAt),
            DateUtils.timeOfDayToString(entry.value.closesAt),
          ],
        ),
      };

  @override
  String toString() {
    return _toJson().toString();
  }
}

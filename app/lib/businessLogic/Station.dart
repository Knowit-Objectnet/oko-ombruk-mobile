import 'package:flutter/material.dart';

class Station {
  final int id;
  final String name;
  final TimeOfDay openingTime;
  final TimeOfDay closingTime;

  Station(
    this.id,
    this.name,
    this.openingTime,
    this.closingTime,
  );

  factory Station.fromJson(Map<String, dynamic> json) {
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

    return Station(
      json['id'],
      json['name'],
      _toTime(json['openingTime']),
      _toTime(json['closingTime']),
    );
  }

  Map<String, dynamic> _toJson() => {
        'id': id,
        'name': name,
        'openingTime': openingTime.toString(),
        'closingTime': closingTime.toString(),
      };

  @override
  String toString() {
    return _toJson().toString();
  }
}

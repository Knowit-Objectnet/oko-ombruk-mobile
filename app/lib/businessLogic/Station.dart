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

  /**
   * TODO
   * This is VERY temporary. It acts as a quick fix due to changes in the backend.
   * We used to only support a shared opening/closing time for each station,
   * but it has been changed to be on a day-to-day basis. Will be fixed later.
   */
  factory Station.fromJson(Map<String, dynamic> json) {
    List<String> tempTime = List<String>.from(json['hours']['MONDAY']);
    String first = tempTime[0];
    String second = tempTime[1];

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
      _toTime(first),
      _toTime(second),
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

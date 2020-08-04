import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ombruk/businessLogic/Partner.dart';
import 'package:ombruk/businessLogic/Station.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';
import 'package:ombruk/globals.dart' as globals;

void main() {
  group('.fromData() initializer', () {
    Partner _partner = Partner(
      1,
      'Fretex',
      'Fretex henter møbler',
      '98234151',
      'example@example.com',
    );

    Station _station = Station(
      1,
      'Fretex',
      TimeOfDay(hour: 8, minute: 0),
      TimeOfDay(hour: 16, minute: 0),
    );

    List<globals.Weekdays> notEmptyWeekdaysList = [globals.Weekdays.monday];
    test('null station', () {
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                startTime: TimeOfDay.now(),
                endTime: TimeOfDay.now(),
                station: null,
                partner: null,
                weekdays: notEmptyWeekdaysList,
                interval: 1,
              ),
          throwsException);
    });

    test('null partner', () {
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                startTime: TimeOfDay.now(),
                endTime: TimeOfDay.now(),
                station: _station,
                partner: null,
                weekdays: [],
                interval: 1,
              ),
          throwsException);
    });

    test('empty weekdays', () {
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                startTime: TimeOfDay.now(),
                endTime: TimeOfDay.now(),
                station: _station,
                partner: _partner,
                weekdays: notEmptyWeekdaysList,
                interval: 1,
              ),
          throwsException);
    });

    test('endTime == startTime', () {
      TimeOfDay now = TimeOfDay.now();
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                startTime: now,
                endTime: now,
                station: _station,
                partner: _partner,
                weekdays: notEmptyWeekdaysList,
                interval: 1,
              ),
          throwsException);
    });

    test('endTime before startTime, same hour', () {
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                startTime: TimeOfDay(hour: 13, minute: 11),
                endTime: TimeOfDay(hour: 12, minute: 11),
                station: _station,
                partner: _partner,
                weekdays: notEmptyWeekdaysList,
                interval: 1,
              ),
          throwsException);
    });

    test('endTime before startTime, different hour', () {
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                startTime: TimeOfDay(hour: 12, minute: 12),
                endTime: TimeOfDay(hour: 12, minute: 11),
                station: _station,
                partner: _partner,
                weekdays: notEmptyWeekdaysList,
                interval: 1,
              ),
          throwsException);
    });

    test('startDate after endDate', () {
      expect(
          () => CreateCalendarEventData.fromData(
                startDate: DateTime.now().add(Duration(days: 1)),
                endDate: DateTime.now(),
                startTime: TimeOfDay(hour: 12, minute: 12),
                endTime: TimeOfDay(hour: 13, minute: 13),
                station: _station,
                partner: _partner,
                weekdays: notEmptyWeekdaysList,
                interval: 1,
              ),
          throwsException);
    });
  });
}

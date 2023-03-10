import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:ombruk/businessLogic/Partner.dart';
import 'package:ombruk/businessLogic/Station.dart';

import 'package:ombruk/globals.dart' as globals;

class CreateCalendarEventData {
  DateTime startDateTime;
  DateTime endDateTime;
  DateTime untilDateTime;
  final Station station;
  final Partner partner;
  final List<globals.Weekdays> weekdays;
  final int interval;

  CreateCalendarEventData.fromData(
      {@required DateTime startDate,
      @required DateTime endDate,
      @required TimeOfDay startTime,
      @required TimeOfDay endTime,
      @required this.station,
      @required this.partner,
      @required this.weekdays,
      @required this.interval})
      : assert(startDate != null),
        assert(endDate != null),
        assert(startTime != null),
        assert(endTime != null),
        assert(weekdays != null) {
    if (station == null) {
      throw Exception('Vennligst velg en stasjon');
    }
    if (partner == null) {
      throw Exception('Vennligst velg en partner');
    }
    if (weekdays.isEmpty) {
      throw Exception('Vennligst velg minst én dag');
    }
    if (startTime.hour > endTime.hour) {
      throw Exception('Start tid kan ikke være før slutt tid');
    }
    if (startTime.hour == endTime.hour && startTime.minute >= endTime.minute) {
      throw Exception('Start tid kan ikke være før eller lik slutt tid');
    }
    if (startDate.isAfter(endDate)) {
      throw Exception('Slutt dato kan ikke være før start dato');
    }

    startDateTime = DateTime(startDate.year, startDate.month, startDate.day,
        startTime.hour, startTime.minute);
    // endDateTime is the same DAY as startDateTime and the same TIME as untilDatetime
    endDateTime = DateTime(startDate.year, startDate.month, startDate.day,
        endTime.hour, endTime.minute);
    untilDateTime = DateTime(
        endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

class CalendarApiClient {
  Future<List<CalendarEvent>> fetchEvents() async {
    final http.Response response =
        await http.get('${globals.calendarBaseUrl}/events');
    if (response.statusCode != 200) {
      throw Exception('Could not fetch events');
    }
    final List<dynamic> parsed = jsonDecode(response.body);
    return parsed.map((e) => CalendarEvent.fromJson(e)).toList();
  }

  Future<bool> createCalendarEvent(CreateCalendarEventData eventData) async {
    final String startString = globals.getDateString(eventData.startDateTime);
    final String endString = globals.getDateString(eventData.endDateTime);
    final String untilString = globals.getDateString(eventData.untilDateTime);

    final List<String> weekdaysString =
        eventData.weekdays.map((e) => describeEnum(e).toUpperCase()).toList();

    final http.Response response = await http.post(
      '${globals.calendarBaseUrl}/events',
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        'startDateTime': startString,
        'endDateTime': endString,
        'station': {'id': eventData.stationID},
        'partner': {'id': eventData.partnerID},
        'recurrenceRule': {'until': untilString, 'days': weekdaysString}
      }),
    );

    return response.statusCode == 200;
  }

  Future<bool> deleteCalendarEvent(int id, DateTime startDate, DateTime endDate,
      dynamic recurrenceRuleID) async {
    String idName;
    String idString;

    if (id == null) {
      idName = 'recurrence-rule-id';
      idString = recurrenceRuleID.toString();
    } else {
      idName = 'event-id';
      idString = id.toString();
    }
    final String startString = globals.getDateString(startDate);
    final String endString = globals.getDateString(endDate);

    var queryParameters = {
      idName: idString,
      'from-date': startString,
      'to-date': endString,
    };

    var url = 'tcuk58u5ge.execute-api.eu-central-1.amazonaws.com';
    var uri = Uri.https(url, '/staging/calendar/events', queryParameters);

    final http.Response response = await http.delete(
      uri,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );

    return response.statusCode == 200;
  }

  Future<bool> updateEvent(
      int id, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    DateTime startDateTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    final String startDateTimeString = globals.getDateString(startDateTime);
    final String endDateTimeString = globals.getDateString(endDateTime);

    final http.Response response = await http.patch(
      '${globals.calendarBaseUrl}/events',
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        'id': id,
        'startDateTime': startDateTimeString,
        'endDateTime': endDateTimeString,
      }),
    );
    print(response.statusCode);

    return response.statusCode == 200;
  }
}

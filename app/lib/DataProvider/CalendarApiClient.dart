import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

class CalendarApiClient {
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

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
      headers: headers,
      body: jsonEncode({
        'startDateTime': startString,
        'endDateTime': endString,
        'station': {'id': eventData.stationID},
        'partner': {'id': eventData.partnerID},
        'recurrenceRule': {'until': untilString, 'days': weekdaysString}
      }),
    );
    print(response.statusCode);

    return response.statusCode == 200;
  }

  Future<bool> deleteCalendarEvent(int id, DateTime startDate, DateTime endDate,
      dynamic recurrenceRuleID) async {
    final String startString = globals.getDateString(startDate);
    final String endString = globals.getDateString(endDate);
    var queryParameters;

    if (id == null) {
      queryParameters = {
        'recurrence-rule-id': recurrenceRuleID.toString(),
        'from-date': startString,
        'to-date': endString
      };
    } else {
      queryParameters = {'event-id': id.toString()};
    }

    var uri = Uri.https('${globals.calendarBaseUrlStripped}',
        '${globals.calendarBaseUrlPath}/events', queryParameters);
    print(uri.toString());
    final http.Response response = await http.delete(
      uri,
      headers: headers,
    );
    print(response.body);
    print(response.statusCode);

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
      headers: headers,
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

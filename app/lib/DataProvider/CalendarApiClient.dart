import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

import 'package:ombruk/globals.dart' as globals;

class CalendarApiClient {
  final String token;

  CalendarApiClient(this.token) {
    if (token != null) {
      _headers.putIfAbsent('Authorization', () => 'Bearer ' + token);
    }
  }

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  /// Returns a list of CalendarEvents on sucecss
  Future<CustomResponse> fetchEvents({int stationID, int partnerID}) async {
    // TODO: Add time parameter to filter on time
    Map<String, String> parameters = {};
    if (stationID != null) {
      parameters.putIfAbsent('station-id', () => stationID.toString());
    }
    if (partnerID != null) {
      parameters.putIfAbsent('partner-id', () => partnerID.toString());
    }

    Uri uri = Uri.https('${globals.calendarBaseUrlStripped}',
        '${globals.requiredPath}/events', parameters);

    final Response response = await get(uri, headers: _headers);

    if (response.statusCode != 200) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: response.body,
      );
    }

    List<CalendarEvent> events;
    try {
      final List<dynamic> parsed = jsonDecode(response.body);
      events = parsed.map((e) => CalendarEvent.fromJson(e)).toList();
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: e.toString() + ' ' + response.body,
      );
    }

    return CustomResponse(
      success: true,
      statusCode: response.statusCode,
      data: events,
      message: null,
    );
  }

  Future<CustomResponse> createCalendarEvent(
      CreateCalendarEventData eventData) async {
    final String startString = globals.getDateString(eventData.startDateTime);
    final String endString = globals.getDateString(eventData.endDateTime);
    final String untilString = globals.getDateString(eventData.untilDateTime);

    final List<String> weekdaysString =
        eventData.weekdays.map((e) => describeEnum(e).toUpperCase()).toList();

    Uri uri = Uri.https(
        '${globals.calendarBaseUrlStripped}', '${globals.requiredPath}/events');

    String body = jsonEncode({
      'startDateTime': startString,
      'endDateTime': endString,
      'stationId': eventData.stationID,
      'partnerId': eventData.partnerID,
      'recurrenceRule': {
        'until': untilString,
        'days': weekdaysString,
        'interval': eventData.interval,
      },
    });

    final Response response = await post(uri, headers: _headers, body: body);

    return CustomResponse(
      success: response.statusCode == 200,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
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

    Uri uri = Uri.https('${globals.calendarBaseUrlStripped}',
        '${globals.requiredPath}/events', queryParameters);

    final Response response = await delete(uri, headers: _headers);

    return response.statusCode == 200; // TODO: return CustomReponse here
  }

  Future<bool> updateEvent(
      int id, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    DateTime startDateTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    final String startDateTimeString = globals.getDateString(startDateTime);
    final String endDateTimeString = globals.getDateString(endDateTime);

    Uri uri = Uri.https(
        '${globals.calendarBaseUrlStripped}', '${globals.requiredPath}/events');

    String body = jsonEncode({
      'id': id,
      'startDateTime': startDateTimeString,
      'endDateTime': endDateTimeString,
    });

    final Response response = await patch(uri, headers: _headers, body: body);

    return response.statusCode == 200; // TODO: return CustomReponse here
  }
}

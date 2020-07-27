import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

class CalendarApiClient {
  Future<List<CalendarEvent>> fetchEvents(
      {int stationID, int partnerID}) async {
    // TODO: Add time parameter to filter on time
    Map<String, String> parameters = {};
    if (stationID != null) {
      parameters.putIfAbsent('station-id', () => stationID.toString());
    }
    if (partnerID != null) {
      parameters.putIfAbsent('partner-id', () => partnerID.toString());
    }

    Uri uri = Uri.https('${globals.calendarBaseUrl}',
        '${globals.calendarPath}/events', parameters);
    final http.Response response = await http.get(uri);
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

    return response.statusCode == 201;
  }
}

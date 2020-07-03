import 'dart:convert';

import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
import 'package:ombruk/models/CalendarEvent.dart';

class CalendarApiClient {
  static const baseUrl = 'https://google.com';

  Future<List<CalendarEvent>> fetchEvents() async {
    await Future.delayed(Duration(seconds: 2)); // TODO

    // ! Remove later
    String json = await rootBundle.loadString('assets/CalendarEvents.json');
    List<dynamic> parsed = jsonDecode(json);
    return parsed.map((e) => CalendarEvent.fromJson(e)).toList();

    /*final http.Response response = await http.get(baseUrl);
    if (response.statusCode != 200) {
      throw Exception('Could not fetch events');
    }
    final List<dynamic> eventsJson = jsonDecode(response.body);
    final List<CalendarEvent> events =
        eventsJson.map((e) => CalendarEvent.fromJson(e)).toList();
    return events;*/
  }
}

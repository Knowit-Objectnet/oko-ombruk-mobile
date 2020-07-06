import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ombruk/models/CalendarEvent.dart';

class CalendarApiClient {
  static const baseUrl = 'https://example.com'; // TODO

  Future<List<CalendarEvent>> fetchEvents() async {
    final http.Response response = await http.get('$baseUrl/events');
    if (response.statusCode != 200) {
      throw Exception('Could not fetch events');
    }
    final List<dynamic> parsed = jsonDecode(response.body);
    return parsed.map((e) => CalendarEvent.fromJson(e)).toList();
  }
}

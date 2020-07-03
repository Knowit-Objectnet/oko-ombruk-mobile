import 'dart:convert';

import 'package:http/http.dart' as http;

class CalendarApiClient {
  static const baseUrl = 'https://';

  Future<bool> fetchEvents() async {
    final http.Response response = await http.get(baseUrl);
    if (response.statusCode != 200) {
      throw Exception('Could not fetch events');
    }
    // final eventJson = jsonDecode(response.body) as List;
    Future.delayed(Duration(seconds: 2));
    return Future.value(false);
  }
}

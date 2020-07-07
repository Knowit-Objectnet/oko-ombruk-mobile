import 'package:http/http.dart';
import 'package:ombruk/globals.dart' as globals;

class WeightReportClient {
  Future<Response> fetchWeightEvents() async {
    final Response response = await get('${globals.baseUrl}/weightEvents');
    if (response.statusCode == 200) {
      return response;
    }
    throw Exception('Could not fetch events');
  }
}

import 'dart:convert';
import 'package:http/http.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/globals.dart' as globals;

class WeightReportService {
  // _headers.putIfAbsent('Authorization', () => 'Bearer ' + token); // TODO

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  /// Returns CustomResponse with a list of WeightReports on success
  Future<CustomResponse<List<WeightReport>>> fetchWeightReports() async {
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/reports');

    final Response response = await get(uri);

    // No auth

    if (response.statusCode == 200) {
      try {
        final List<dynamic> parsed = jsonDecode(response.body);
        List<WeightReport> reports =
            parsed.map((e) => WeightReport.fromJson(e)).toList();
        return CustomResponse(
          success: true,
          statusCode: response.statusCode,
          data: reports,
        );
      } catch (e) {
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
        );
      }
    }
    return CustomResponse(
      success: false,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }

  /// Returns a CustomResponse with a WeightReport if it was sucecssfully added
  Future<CustomResponse<WeightReport>> addWeight(int id, int weight) async {
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/reports');

    final String body = jsonEncode({'id': id, 'weight': weight});

    final Response response = await patch(
      uri,
      headers: _headers,
      body: body,
    );

    // TODO all auth

    if (response.statusCode == 200) {
      try {
        final dynamic parsed = jsonDecode(response.body);
        return CustomResponse(
          success: true,
          statusCode: response.statusCode,
          data: WeightReport.fromJson(parsed),
        );
      } catch (error) {
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: error.toString(),
        );
      }
    }
    return CustomResponse(
      success: false,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }
}

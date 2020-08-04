import 'dart:convert';
import 'package:http/http.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/services/serviceLocator.dart';

class WeightReportService {
  final UserViewModel _userViewModel = serviceLocator<UserViewModel>();

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  void _updateTokenInHeader() {
    _headers.putIfAbsent(
        'Authorization', () => 'Bearer ' + (_userViewModel?.accessToken ?? ''));
  }

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
    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/reports');

    final String body = jsonEncode({'id': id, 'weight': weight});

    Response response = await patch(
      uri,
      headers: _headers,
      body: body,
    );

    // All roles authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        response = await patch(
          uri,
          headers: _headers,
          body: body,
        );
      } else {
        // Log out due to invalid refesh token
        await _userViewModel.requestLogOut();
      }
    }

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

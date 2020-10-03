import 'dart:convert';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/Api.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';

class WeightReportService {
  final Api _api = Api();

  /// Returns CustomResponse with a list of WeightReports on success
  Future<CustomResponse<List<WeightReport>>> fetchWeightReports(
    ReportGetForm form,
  ) async {
    CustomResponse response =
        await _api.getRequest(ApiEndpoint.weightReports, form);

    if (!response.success) {
      return response;
    }

    try {
      List<WeightReport> reports = List<dynamic>.from(jsonDecode(response.data))
          .map((json) => WeightReport.fromJson(json))
          .toList();
      return CustomResponse(
          success: true, statusCode: response.statusCode, data: reports);
    } catch (error) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: "Failed to parse stations",
      );
    }
  }

  /// Returns a CustomResponse with a WeightReport if it was sucecssfully added
  Future<CustomResponse<WeightReport>> patchWeight(int id, int weight) async {
    final String body = jsonEncode({'id': id, 'weight': weight});

    CustomResponse response =
        await _api.patchRequest(ApiEndpoint.weightReports, body);

    if (!response.success) {
      return response;
    }

    try {
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: WeightReport.fromJson(jsonDecode(response.data)),
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
}

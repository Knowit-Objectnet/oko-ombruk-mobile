import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';
import 'package:ombruk/services/forms/report/ReportPatchForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/interfaces/IWeightReportService.dart';
import 'package:ombruk/services/mixins/ParseResponse.dart';

class WeightReportService with ParseResponse implements IWeightReportService {
  ICacheService _cacheService;
  WeightReportService(this._cacheService);

  /// Returns CustomResponse with a list of WeightReports on success
  @override
  Future<CustomResponse<List<WeightReport>>> fetchWeightReports(
    ReportGetForm form, {
    Function(CustomResponse<List<WeightReport>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      path: ApiEndpoint.weightReports,
      form: form,
      parser: _parseResponse,
      newDataCallback: newDataCallback,
    );

    return response.success ? _parseResponse(response) : response;
  }

  CustomResponse<List<WeightReport>> _parseResponse(CustomResponse response) {
    return parseList<WeightReport>(
      response,
      (report) => WeightReport.fromJson(report),
    );
  }

  /// Returns a CustomResponse with a WeightReport if it was sucecssfully added
  Future<CustomResponse<WeightReport>> patchWeight(ReportPatchForm form) async {
    CustomResponse response =
        await _cacheService.patchRequest(ApiEndpoint.weightReports, form);

    return response.success
        ? parseObject<WeightReport>(
            response, (report) => WeightReport.fromJson(report))
        : response;
  }

  @override
  void updateDependencies(ICacheService cacheService) {
    _cacheService = cacheService;
  }

  @override
  void removeCallback(Function function) {
    _cacheService.removeCallback(function, ApiEndpoint.weightReports);
  }
}

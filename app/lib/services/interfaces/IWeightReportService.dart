import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';
import 'package:ombruk/services/forms/report/ReportPatchForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';

abstract class IWeightReportService {
  Future<CustomResponse<List<WeightReport>>> fetchWeightReports(
    ReportGetForm form, {
    Function(CustomResponse<List<WeightReport>>) newDataCallback,
  });

  Future<CustomResponse<WeightReport>> patchWeight(ReportPatchForm form);

  void updateDependencies(ICacheService cacheService);
  void removeCallback(Function function);
}

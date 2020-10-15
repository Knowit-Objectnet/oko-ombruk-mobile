import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';
import 'package:ombruk/services/forms/report/ReportPatchForm.dart';

abstract class IWeightReportService {

  Future<CustomResponse<List<WeightReport>>> fetchWeightReports(ReportGetForm form);

  Future<CustomResponse<WeightReport>> patchWeight(ReportPatchForm form);
}
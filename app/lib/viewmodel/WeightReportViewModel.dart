import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';
import 'package:ombruk/services/forms/report/ReportPatchForm.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/IWeightReportService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class WeightReportViewModel extends BaseViewModel {
  final IWeightReportService _weightReportService;
  final IAuthenticationService _authenticationService;
  WeightReportViewModel(this._weightReportService, this._authenticationService);

  List<WeightReport> _nonReportedList = List();
  List<WeightReport> _reportedList = List();

// Use unmodifiable list here maybe
  List<WeightReport> get nonReportedList => _nonReportedList;
  List<WeightReport> get reportedList => _reportedList;

  Future<bool> fetchWeightReports() async {
    int groupId = _authenticationService.userModel.groupID;
    ReportGetForm form = ReportGetForm(partnerId: groupId);

    final CustomResponse<List<WeightReport>> weightResponse =
        await _weightReportService.fetchWeightReports(form);

    if (weightResponse.success) {
      List<WeightReport> tempNonReported = [];
      List<WeightReport> tempReported = [];

      for (WeightReport weightReport in weightResponse.data) {
        if (weightReport.weight != null) {
          tempReported.add(weightReport);
        } else {
          tempNonReported.add(weightReport);
        }
      }

      _nonReportedList = tempNonReported;
      _reportedList = tempReported;

      notifyListeners();
      return true;
    } else {
      print(weightResponse);
      return false;
    }
  }

  Future<bool> addWeight(WeightReport weightReport, int newWeight) async {
    ReportPatchForm form =
        ReportPatchForm(reportId: weightReport.reportID, weight: newWeight);
    final CustomResponse<WeightReport> response =
        await _weightReportService.patchWeight(form);

    if (response.success) {
      _nonReportedList.remove(weightReport);
      weightReport.weight = newWeight;
      _reportedList.add(weightReport);

      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> updateWeight(WeightReport weightReport, int newWeight) async {
    ReportPatchForm form =
        ReportPatchForm(reportId: weightReport.reportID, weight: newWeight);
    final CustomResponse<WeightReport> response =
        await _weightReportService.patchWeight(form);

    if (response.success) {
      final int index = _reportedList
          .indexWhere((element) => element.eventID == weightReport.eventID);
      _reportedList[index].weight = newWeight;

      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }
}

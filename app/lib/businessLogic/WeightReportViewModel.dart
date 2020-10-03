import 'package:flutter/cupertino.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/WeightReportService.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';
import 'package:ombruk/services/serviceLocator.dart';

class WeightReportViewModel extends ChangeNotifier {
  final WeightReportService _weightReportService =
      serviceLocator<WeightReportService>();
  final UserViewModel _userViewModel = serviceLocator<UserViewModel>();

  List<WeightReport> _nonReportedList;
  List<WeightReport> _reportedList;

// Use unmodifiable list here maybe
  List<WeightReport> get nonReportedList => _nonReportedList;
  List<WeightReport> get reportedList => _reportedList;

  Future<bool> fetchWeightReports() async {
    //I'd love to remove the userviewmodel dependency but not sure if possible.
    ReportGetForm form = ReportGetForm(partnerId: _userViewModel.groupID);

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
    final CustomResponse<WeightReport> response =
        await _weightReportService.patchWeight(weightReport.eventID, newWeight);

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
    final CustomResponse<WeightReport> response =
        await _weightReportService.patchWeight(weightReport.eventID, newWeight);

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

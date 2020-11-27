import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/WeightReport.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/report/ReportGetForm.dart';
import 'package:ombruk/services/forms/report/ReportPatchForm.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/services/interfaces/IWeightReportService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class WeightReportViewModel extends BaseViewModel {
  final IWeightReportService _weightReportService;
  final IAuthenticationService _authenticationService;
  final INavigatorService _navigatorService;
  final SnackbarService _snackbarService;
  final DialogService _dialogService;
  WeightReportViewModel(
    this._weightReportService,
    this._authenticationService,
    this._navigatorService,
    this._snackbarService,
    this._dialogService,
  );

  List<WeightReport> _nonReportedList = List();
  List<WeightReport> _reportedList = List();

// Use unmodifiable list here maybe
  List<WeightReport> get nonReportedList => _nonReportedList;
  List<WeightReport> get reportedList => _reportedList;

  @override
  Future<void> init() {}

  Future<bool> fetchWeightReports() async {
    int groupId = _authenticationService.userModel.groupID;
    ReportGetForm form = ReportGetForm(partnerId: groupId);

    final CustomResponse<List<WeightReport>> weightResponse =
        await _weightReportService.fetchWeightReports(
      form,
      newDataCallback: _onReportsChanged,
    );

    if (weightResponse.success) {
      _addReports(weightResponse.data);
      notifyListeners();
      return true;
    } else {
      _snackbarService.showSimpleSnackbar("Kunne ikke hente vektrapporter.");
      return false;
    }
  }

  void _addReports(List<WeightReport> reports) {
    _nonReportedList = List();
    _reportedList = List();
    reports.forEach((report) {
      if (report.weight == null) {
        _nonReportedList.add(report);
      } else {
        _reportedList.add(report);
      }
    });
  }

  void _onReportsChanged(CustomResponse<List<WeightReport>> response) {
    print("_onReportsChanged called!");
    _addReports(response.data);
    notifyListeners();
  }

  Future<void> addWeight(WeightReport weightReport, int newWeight) async {
    ReportPatchForm form =
        ReportPatchForm(reportId: weightReport.reportId, weight: newWeight);
    final CustomResponse<WeightReport> response =
        await _weightReportService.patchWeight(form);
    //_navigatorService.goBack();

    if (response.success) {
      _nonReportedList.remove(weightReport);
      weightReport.weight = newWeight;
      _reportedList.add(weightReport);
      notifyListeners();
      _snackbarService.showSimpleSnackbar("OK!");
    } else {
      _snackbarService.showSimpleSnackbar("Kunne ikke rapportere vekten.");
      print("hi2 $response");
    }
  }

  Future<void> updateWeight(WeightReport weightReport, int newWeight) async {
    ReportPatchForm form =
        ReportPatchForm(reportId: weightReport.reportId, weight: newWeight);
    _dialogService.showLoading();
    final CustomResponse<WeightReport> response =
        await _weightReportService.patchWeight(form);
    _dialogService.hideLoading();

    if (response.success) {
      weightReport.weight = response.data.weight;
      _snackbarService.showSimpleSnackbar("OK!");
      notifyListeners();
    } else {
      _snackbarService.showSimpleSnackbar("Kunne ikke rapportere vekten.");
      print("hi3 $response");
    }
  }

  void goBack() {
    _navigatorService.goBack();
  }

  void onDialog(dynamic dialog) {
    _dialogService.showCustomDialog(dialog);
  }

  @override
  void dispose() {
    super.dispose();
    _weightReportService.removeCallback(_onReportsChanged);
  }
}

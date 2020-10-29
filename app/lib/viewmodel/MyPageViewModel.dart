import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class MyPageViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  final SnackbarService _snackbarService;
  final DialogService _dialogService;
  final INavigatorService _navigatorService;
  MyPageViewModel(this._authenticationService, this._navigatorService,
      this._snackbarService, this._dialogService) {
    _authenticationService
        .loadFromStorage()
        .then((value) =>
            getRole(value.roles.firstWhere((role) => getRole(role) != null)))
        .then((value) {
      _role = value;
      notifyListeners();
    });
  }
  KeycloakRoles _role;
  KeycloakRoles get role => _role;

  bool _showContactInfo = false; // TODO: Get this from data
  bool get showContactInfo => _showContactInfo;

  void onShowContactInfoChanged() {
    _showContactInfo = !_showContactInfo;
    notifyListeners();
  }

  void requestLogOut() async {
    _dialogService.showLoading();
    final CustomResponse response =
        await _authenticationService.requestLogOut1();
    _dialogService.hideLoading();
    if (response.success) {
      await _authenticationService.deleteCredentials();
      _navigatorService.toInitial();
    } else {
      _snackbarService.showSimpleSnackbar("Kunne ikke logge deg ut.");
    }
  }

  void onNewStation() {
    _navigatorService.navigateTo(Routes.NewStationView);
  }

  void onNewPartner() {
    _navigatorService.navigateTo(Routes.NewPartnerView);
  }
}

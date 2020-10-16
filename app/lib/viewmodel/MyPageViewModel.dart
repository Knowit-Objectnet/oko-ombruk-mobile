import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class MyPageViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  final INavigatorService _navigatorService;
  MyPageViewModel(this._authenticationService, this._navigatorService) {
    _role = getRole(_authenticationService.userModel.roles
        .firstWhere((role) => getRole(role) != null));
  }
  KeycloakRoles _role;
  KeycloakRoles get role => _role;

  bool _showContactInfo = false; // TODO: Get this from data
  bool get showContactInfo => _showContactInfo;

  void onShowContactInfoChanged() {
    _showContactInfo = !_showContactInfo;
    notifyListeners();
  }

  Future<bool> requestLogOut() async {
    final CustomResponse response =
        await _authenticationService.requestLogOut1();
    if (response.success) {
      await _authenticationService.deleteCredentials();
      _navigatorService.toInitial();
      return true;
    } else {
      print('Logout error: ${response.toString()}');
      return false;
    }
  }
}

import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class AppViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  KeycloakRoles get role {
    if (_authenticationService.userModel == null ||
        _authenticationService.userModel.roles == null) {
      return null;
    } else {
      return getRole(_authenticationService.userModel.roles
          .firstWhere((role) => role != null, orElse: () => null));
    }
  }

  AppViewModel(this._authenticationService) {
    setState(ViewState.Busy);
    Future.delayed(Duration(seconds: 1)).then(
        (value) => _authenticationService.loadFromStorage().then((userModel) {
              setState(ViewState.Idle);
            }));
  }
}

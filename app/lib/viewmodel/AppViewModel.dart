import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class AppViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  KeycloakRoles _role;
  KeycloakRoles get role => _role;

  AppViewModel(this._authenticationService) {
    setState(ViewState.Busy);
    _authenticationService.loadFromStorage().then((userModel) {
      if (userModel == null ||
          userModel.roles == null ||
          userModel.roles.isEmpty) {
        _role = null;
      } else {
        _role = getRole(userModel.roles
            .firstWhere((role) => getRole(role) != null, orElse: () => null));
      }
      setState(ViewState.Idle);
    });
  }
}

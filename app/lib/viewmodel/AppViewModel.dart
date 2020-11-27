import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class AppViewModel extends BaseViewModel {
  final IAuthenticationService _authenticationService;
  KeycloakRoles _role;
  KeycloakRoles get role => _role;

  AppViewModel(this._authenticationService) : super(state: ViewState.Busy);

  @override
  Future<void> init() async {
    await Future.delayed(Duration(seconds: 1));
    await _authenticationService.getUserInfo().then((value) {
      _role = value?.role;
    });
    setState(ViewState.Idle);
  }
}

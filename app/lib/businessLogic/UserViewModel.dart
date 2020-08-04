import 'package:flutter/foundation.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:openid_client/openid_client.dart';

import 'package:ombruk/businessLogic/UserModel.dart';
import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/models/CustomResponse.dart';

import 'package:ombruk/globals.dart' as globals;

class UserViewModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      serviceLocator<AuthenticationService>();

  UserModel _user;

  UserViewModel() {
    loadFromStorage();
  }

  String get accessToken => _user?.accessToken;

  // String get accessToken => _accessToken;

  Future<void> loadFromStorage() async {
    final UserModel user = await _authenticationService.loadFromStorage();
    _user = user;
    notifyListeners();
  }

  Future<void> deleteCredentials() async {
    await _authenticationService.deleteCredentials();
    _user = null;
    notifyListeners();
  }

  Future<bool> requestLogOut() async {
    final CustomResponse response = await _authenticationService.requestLogOut(
      _user.accessToken,
      _user.refreshToken,
      _user.clientId,
    );
    if (response.success) {
      await deleteCredentials();
      return true;
    } else {
      print('Logout error: ${response.toString()}');
      return false;
    }
  }

  Future<void> saveCredentials(
      Credential credential, List<String> roles) async {
    final UserModel user =
        await _authenticationService.saveCredentials(credential, roles);
    _user = user;
    notifyListeners();
  }

// TODO: remove this function, call loadFromStorage on app start instead.
  Future<bool> hasCredentials() async {
    _user = await _authenticationService.loadFromStorage();
    return _user.accessToken != null;
  }

  Future<bool> requestRefreshToken() async {
    final CustomResponse<UserModel> response =
        await _authenticationService.requestRefreshToken(
      _user?.refreshToken,
      _user?.clientId,
    );
    if (!response.success) {
      print(response);
      return false;
    }
    UserModel newUser = response.data;
    _user.accessToken = newUser.accessToken;
    _user.refreshToken = newUser.refreshToken;
    notifyListeners();
    return true;
  }

  /// returns a value from [globals.KeycloakRoles] or null if no match
  globals.KeycloakRoles getRole() {
    if (_user.roles.contains(describeEnum(globals.KeycloakRoles.partner))) {
      return globals.KeycloakRoles.partner;
    }
    if (_user.roles
        .contains(describeEnum(globals.KeycloakRoles.reg_employee))) {
      return globals.KeycloakRoles.reg_employee;
    }
    if (_user.roles
        .contains(describeEnum(globals.KeycloakRoles.reuse_station))) {
      return globals.KeycloakRoles.reuse_station;
    }
    return null;
  }
}

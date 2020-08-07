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

  // We don't use UserModel as the data here, because there is some funny
  // business with notifyListeners() on an object.
  String _accessToken;
  String _refreshToken;
  String _clientId;
  List<String> _roles;
  int _groupID;
  bool _isLoaded = false;

  UserViewModel() {
    initLoadFromStorage();
  }

  String get accessToken => _accessToken;
  bool get isLoaded => _isLoaded;
  int get groupID => _groupID;

  Future<void> initLoadFromStorage() async {
    final UserModel user = await _authenticationService.loadFromStorage();
    _accessToken = user.accessToken;
    _refreshToken = user.refreshToken;
    _clientId = user.clientId;
    _roles = user.roles;
    _groupID = user.groupID;
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> deleteCredentials() async {
    await _authenticationService.deleteCredentials();
    _accessToken = null;
    _refreshToken = null;
    _clientId = null;
    _roles = null;
    _groupID = null;
    notifyListeners();
  }

  Future<bool> requestLogOut() async {
    final CustomResponse response = await _authenticationService.requestLogOut(
      _accessToken,
      _refreshToken,
      _clientId,
    );
    if (response.success) {
      await deleteCredentials();
      return true;
    } else {
      print('Logout error: ${response.toString()}');
      return false;
    }
  }

  Future<void> saveCredentials({
    @required Credential credential,
    @required List<String> roles,
    @required int groupID,
  }) async {
    final UserModel user = await _authenticationService.saveCredentials(
      credential: credential,
      roles: roles,
      groupID: groupID,
    );
    _accessToken = user.accessToken;
    _refreshToken = user.refreshToken;
    _clientId = user.clientId;
    _roles = user.roles;
    _groupID = user.groupID;
    notifyListeners();
  }

  Future<bool> requestRefreshToken() async {
    final CustomResponse<UserModel> response =
        await _authenticationService.requestRefreshToken(
      clientId: _clientId,
      refreshToken: _refreshToken,
    );
    if (!response.success) {
      print(response);
      return false;
    }

    UserModel newUser = response.data;
    _accessToken = newUser.accessToken;
    _refreshToken = newUser.refreshToken;
    notifyListeners();
    return true;
  }

  /// returns a value from [globals.KeycloakRoles] or null if no match
  globals.KeycloakRoles getRole() {
    if (_roles == null) {
      return null;
    }
    if (_roles.contains(describeEnum(globals.KeycloakRoles.partner))) {
      return globals.KeycloakRoles.partner;
    }
    if (_roles.contains(describeEnum(globals.KeycloakRoles.reg_employee))) {
      return globals.KeycloakRoles.reg_employee;
    }
    if (_roles.contains(describeEnum(globals.KeycloakRoles.reuse_station))) {
      return globals.KeycloakRoles.reuse_station;
    }
    return null;
  }
}

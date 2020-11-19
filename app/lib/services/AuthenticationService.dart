import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/models/UserInfo.dart';
import 'package:ombruk/models/UserModel.dart';
import 'package:ombruk/services/SecureStorageService.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/ISecureStorageService.dart';
import 'package:openid_client/openid_client.dart' as OID;
import 'package:http/http.dart';

import 'package:ombruk/models/CustomResponse.dart';

class AuthenticationService implements IAuthenticationService {
  ISecureStorageService _localStorageService = SecureStorageService();
  AuthenticationService();
  AuthenticationService.test(this._localStorageService);

  UserModel _userModel;

  UserInfo _userInfo;

  Future<UserModel> loadFromStorage() async {
    final String accessToken =
        await _localStorageService.getValue(key: "accessToken");
    final String refreshToken =
        await _localStorageService.getValue(key: 'refreshToken');
    final String clientId =
        await _localStorageService.getValue(key: 'clientId');
    final String groupIDString =
        await _localStorageService.getValue(key: 'groupID');

    final String roleString = await _localStorageService.getValue(key: 'roles');
    List<String> roles;
    if (roleString != null) {
      List<dynamic> list = jsonDecode(roleString);
      roles = list.map((role) => role.toString()).toList();
    }

    int groupID;
    if (groupIDString != null) {
      groupID = int.parse(groupIDString);
    }
    _userModel = UserModel(accessToken, refreshToken, clientId, roles, groupID);

    if (roles != null) {
      KeycloakRoles role = getRole(
          roles.firstWhere((role) => getRole(role) != null, orElse: null));
      _userInfo = UserInfo(role, groupID);
    }
    return _userModel;
  }

  Future<void> deleteCredentials() async {
    await _localStorageService.deleteAll();
  }

  /// Makes an API call to log out.
  Future<CustomResponse> requestLogOut(
      String accessToken, String refreshToken, String clientID) async {
    assert(accessToken != null);
    assert(refreshToken != null);
    assert(clientID != null);

    String url =
        '${ApiEndpoint.keycloakBaseUrl}/protocol/openid-connect/logout';
    Map<String, String> headers = {};
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer ' + accessToken;
    }
    headers['Content-Type'] = 'application/x-www-form-urlencoded';

    try {
      final response = await post(
        url,
        headers: headers,
        body: {'client_id': clientID, 'refresh_token': refreshToken},
      );
      _userModel = null;
      return CustomResponse(
        success: response.statusCode == 204,
        statusCode: response.statusCode,
        data: null,
      );
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: null,
        data: null,
        message: e.toString(),
      );
    }
  }

  Future<UserModel> saveCredentials({
    @required OID.Credential credential,
    List<String> roles,
    int groupID,
  }) async {
    Map<String, dynamic> map = credential.response;
    final String accessToken = map['access_token'].toString();
    final String refreshToken = credential.refreshToken;
    final String clientId = credential.client.clientId;

    await _localStorageService.setValue(key: "accessToken", value: accessToken);
    await _localStorageService.setValue(
        key: "refreshToken", value: refreshToken);
    await _localStorageService.setValue(key: "clientId", value: clientId);
    await _localStorageService.setValue(key: 'roles', value: jsonEncode(roles));
    await _localStorageService.setValue(
        key: 'groupID', value: groupID?.toString());

    _userModel = UserModel(accessToken, refreshToken, clientId, roles, groupID);

    KeycloakRoles role = getRole(
        roles.firstWhere((role) => getRole(role) != null, orElse: null));
    _userInfo = UserInfo(role, groupID);
    return _userModel;
  }

  /// Makes an API call to get new tokens. Returns a [UserModel] with ONLY accessToken and refreshToken
  Future<CustomResponse<UserModel>> requestRefreshToken() async {
    String url = '${ApiEndpoint.keycloakBaseUrl}/protocol/openid-connect/token';
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/x-www-form-urlencoded';

    // Since we use x-www-form-urlencoded, we don't use jsonEncode()
    Map<String, String> bodyForm = {
      'grant_type': 'refresh_token',
      'client_id': _userModel.clientId,
      'refresh_token': _userModel.refreshToken,
    };

    final response = await post(
      url,
      headers: headers,
      body: bodyForm,
    );

    if (response.statusCode != 200) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: response.body,
      );
    }

    final Map<String, dynamic> map = jsonDecode(response.body);
    String newAccessToken = map['access_token'];
    String newRefreshToken = map['refresh_token'];

    await _localStorageService.setValue(
        key: "accessToken", value: newAccessToken);
    await _localStorageService.setValue(
        key: "refreshToken", value: newRefreshToken);
    _userModel.accessToken = newAccessToken;
    _userModel.refreshToken = newRefreshToken;

    return CustomResponse(
      success: true,
      statusCode: response.statusCode,
      data: UserModel(newAccessToken, newRefreshToken, null, null, null),
    );
  }

  @override
  Future<CustomResponse> requestLogOut1() async {
    String url =
        '${ApiEndpoint.keycloakBaseUrl}/protocol/openid-connect/logout';
    Map<String, String> headers = {};
    if (userModel.accessToken != null) {
      headers['Authorization'] = 'Bearer ' + userModel.accessToken;
    }
    headers['Content-Type'] = 'application/x-www-form-urlencoded';

    try {
      final response = await post(
        url,
        headers: headers,
        body: {
          'client_id': userModel.clientId,
          'refresh_token': userModel.refreshToken
        },
      );
      _userModel = null;
      _userInfo = null;
      return CustomResponse(
        success: response.statusCode == 204,
        statusCode: response.statusCode,
        data: null,
      );
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: null,
        data: null,
        message: e.toString(),
      );
    }
  }

  @override
  UserModel get userModel => _userModel;

  @override
  Future<UserInfo> getUserInfo() async {
    if (_userInfo == null) {
      await loadFromStorage();
    }
    return _userInfo;
  }
}

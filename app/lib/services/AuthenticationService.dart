import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:ombruk/businessLogic/UserModel.dart';
import 'package:ombruk/services/LocalStorageService.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/ILocalStorageService.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:http/http.dart';

import 'package:ombruk/models/CustomResponse.dart';

import 'package:ombruk/globals.dart' as globals;

class AuthenticationService implements IAuthenticationService {
  final ILocalStorageService _localStorageService = LocalStorageService();

  Future<UserModel> loadFromStorage() async {
    final String accessToken = await _localStorageService.getValue(key: "accessToken");
    final String refreshToken = await _localStorageService.getValue(key: 'refreshToken');
    final String clientId = await _localStorageService.getValue(key: 'clientId');
    final String groupIDString = await _localStorageService.getValue(key: 'groupID');

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

    return UserModel(accessToken, refreshToken, clientId, roles, groupID);
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

    String url = '${globals.keycloakBaseUrl}/protocol/openid-connect/logout';
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
    @required Credential credential,
    List<String> roles,
    int groupID,
  }) async {
    Map<String, dynamic> map = credential.response;
    final String accessToken = map['access_token'].toString();
    final String refreshToken = credential.refreshToken;
    final String clientId = credential.client.clientId;

    await _localStorageService.setValue(key: "accessToken", value: accessToken);
    await _localStorageService.setValue(key: "refreshToken", value: refreshToken);
    await _localStorageService.setValue(key: "clientId", value: clientId);
    await _localStorageService.setValue(key: 'roles', value: jsonEncode(roles));
    await _localStorageService.setValue(key: 'groupID', value: groupID?.toString());

    return UserModel(accessToken, refreshToken, clientId, roles, groupID);
  }

  /// Makes an API call to get new tokens. Returns a [UserModel] with ONLY accessToken and refreshToken
  Future<CustomResponse<UserModel>> requestRefreshToken({
    @required String clientId,
    @required String refreshToken,
  }) async {
    assert(clientId != null);
    assert(refreshToken != null);

    String url = '${globals.keycloakBaseUrl}/protocol/openid-connect/token';
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/x-www-form-urlencoded';

    // Since we use x-www-form-urlencoded, we don't use jsonEncode()
    Map<String, String> bodyForm = {
      'grant_type': 'refresh_token',
      'client_id': clientId,
      'refresh_token': refreshToken,
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

    await _localStorageService.setValue(key: "accessToken", value: newAccessToken);
    await _localStorageService.setValue(key: "refreshToken", value: newRefreshToken);

    return CustomResponse(
      success: true,
      statusCode: response.statusCode,
      data: UserModel(newAccessToken, newRefreshToken, null, null, null),
    );
  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:ombruk/globals.dart' as globals;

class UserRepository {
  final storage = FlutterSecureStorage();
  String _accessToken;
  String _refreshToken;
  String _clientId;
  List<String> _roles = [];

  String get accessToken => _accessToken;

  Future<void> loadFromStorage() async {
    _accessToken = await storage.read(key: "accessToken");
    _refreshToken = await storage.read(key: 'refreshToken');
    _clientId = await storage.read(key: 'clientId');

    String roleString = await storage.read(key: 'roles');
    if (roleString != null) {
      List<dynamic> list = jsonDecode(roleString);
      _roles = list.map((e) => e.toString()).toList();
    }
  }

  Future<void> deleteCredentials() async {
    await storage.deleteAll();
  }

  Future<bool> requestLogOut() async {
    String url = '${globals.keycloakBaseUrl}/protocol/openid-connect/logout';
    Map<String, String> headers = {};
    headers['Authorization'] = 'Bearer ' + _accessToken;
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    final response = await http.post(url,
        headers: headers,
        body: {'client_id': _clientId, 'refresh_token': _refreshToken});
    return response.statusCode == 204;
  }

  Future<void> saveCredentials(
      Credential credential, List<String> roles) async {
    Map<String, dynamic> map = credential.response;
    _accessToken = map['access_token'].toString();
    _refreshToken = credential.refreshToken;
    _clientId = credential.client.clientId;
    this._roles = roles;

    await storage.write(key: "accessToken", value: _accessToken);
    await storage.write(key: "refreshToken", value: _refreshToken);
    await storage.write(key: "clientId", value: _clientId);
    await storage.write(key: 'roles', value: jsonEncode(roles));
  }

  Future<bool> hasCredentials() async {
    String accessToken = await storage.read(key: "accessToken");
    return accessToken != null;
  }

  /// Makes an API call to get new tokens. Returns a boolean of success status.
  Future<bool> requestRefreshToken() async {
    String url = '${globals.keycloakBaseUrl}/protocol/openid-connect/token';
    Map<String, String> headers = {};
    headers['Content-Type'] = 'application/x-www-form-urlencoded';

    String body = jsonEncode({
      'client_id': _clientId,
      'grant-type': 'refresh-token',
      'refresh_token': _refreshToken,
    });

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode != 200) {
      return false;
    }

    final Map<String, dynamic> map = jsonDecode(response.body);
    _accessToken = map['access_token'];
    _refreshToken = map['refresh_token'];

    await storage.write(key: "accessToken", value: _accessToken);
    await storage.write(key: "refreshToken", value: _refreshToken);

    return true;
  }

  /// returns a value from [globals.KeycloakRoles] or null if no match
  globals.KeycloakRoles getRole() {
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

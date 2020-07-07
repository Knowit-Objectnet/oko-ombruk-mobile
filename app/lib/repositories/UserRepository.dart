import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final storage = FlutterSecureStorage();
  String accessToken;
  String expiresAt;
  String refreshToken;
  String clientId;
  String clientSecret;

  Future<void> init() async {
    expiresAt = await storage.read(key: "expiresAt");
    accessToken = await storage.read(key: "accessToken");
    refreshToken = await storage.read(key: 'refreshToken');
    clientId = await storage.read(key: 'clientId');
  }

  /*void printTokens() {
    print("expiresAt: " + (expiresAt ?? ''));
    print("accessToken: " + (accessToken ?? ''));
    print("refreshToken: " + (refreshToken ?? ''));
    print("clientId: " + (clientId ?? ''));
    print("clientSecret: " + (clientSecret ?? ''));
  }*/

  Future<void> deleteCredentials() async {
    await storage.deleteAll();
  }

  Future<bool> requestLogOut() async {
    var url =
        'https://keycloak.staging.oko.knowit.no:8443/auth/realms/staging/protocol/openid-connect/logout';
    Map<String, String> headers = {};
    headers['Authorization'] = 'Bearer ' + accessToken;
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    final response = await http.post(url,
        headers: headers,
        body: {'client_id': clientId, 'refresh_token': refreshToken});
    return response.statusCode == 204;
  }

  Future<void> saveCredentials(Credential credential) async {
    Map<String, dynamic> map = credential.response;
    expiresAt = map['expires_at'].toString();
    accessToken = map['access_token'].toString();
    refreshToken = credential.refreshToken;
    clientId = credential.client.clientId;
    clientSecret = credential.client.clientSecret;

    storage.write(key: "expiresAt", value: expiresAt);
    storage.write(key: "accessToken", value: accessToken);
    storage.write(key: "refreshToken", value: refreshToken);
    storage.write(key: "clientId", value: clientId);
    storage.write(key: "clientSecret", value: clientSecret);
  }

  Future<bool> hasCredentials() async {
    await init();

    /// read from keystore/keychain
    // String expiresAt = await storage.read(key: "expires_at");
    String accessToken = await storage.read(key: "accessToken");
    return accessToken != null;
  }

  Future<bool> requestRefreshToken() async {
    //TODO: make api call to get a new token
    return false;
  }
}
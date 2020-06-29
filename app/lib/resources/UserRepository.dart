import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final storage = FlutterSecureStorage();

  Future<void> deleteCredentials() async {
    await storage.deleteAll();
  }

  Future<void> saveCredentials(Credential credential) async {
    Map<String, dynamic> map = credential.response;
    String expiresAt = map['expires_at'].toString();
    String accessToken = map['access_token'].toString();
    storage.write(key: "expires_at", value: expiresAt);
    storage.write(key: "access_token", value: accessToken);
  }

  Future<bool> hasCredentials() async {
    /// read from keystore/keychain
    // String expiresAt = await storage.read(key: "expires_at");
    String accessToken = await storage.read(key: "access_token");
    return accessToken != null;
  }

  Future<bool> refreshToken() async {
    //TODO: make api call to get a new token
    return false;
  }
}

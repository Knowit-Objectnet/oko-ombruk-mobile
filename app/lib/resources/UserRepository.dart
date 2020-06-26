import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

class UserRepository {
  Future<String> authenticateUserpass(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<UserInfo> authenticate() async {
    final Uri uri = Uri.parse(
        "http://ombruk-ecs-public-staging-85208200.eu-central-1.elb.amazonaws.com:8080/auth/realms/staging");
    final String clientId = "flutter-app";
    final List<String> scopes = ["openid", "profile"];

    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clientId);

    Future<Null> urlLauncher(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    var authenticator = new Authenticator(
      client,
      scopes: scopes,
      port: 4200,
      urlLancher: urlLauncher,
    );

    Credential credential = await authenticator.authorize();
    closeWebView();
    return await credential.getUserInfo();
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}

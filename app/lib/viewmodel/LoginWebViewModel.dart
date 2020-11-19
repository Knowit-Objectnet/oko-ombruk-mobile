import 'package:flutter/widgets.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jose/jose.dart';
import 'package:ombruk/globals.dart' as globals;

class LoginWebViewModel extends BaseViewModel with WidgetsBindingObserver {
  IAuthenticationService _authenticationService;
  INavigatorService _navigatorService;
  LoginWebViewModel(
    this._authenticationService,
    this._navigatorService,
  ) {
    WidgetsBinding.instance.addObserver(this);
  }
  final Uri uri = Uri.parse('${ApiEndpoint.keycloakBaseUrl}');
  final String clientId = 'flutter-app';
  final List<String> scopes = ['openid', 'profile', 'offline_access'];
  void login() async {
    try {
      final Issuer issuer = await Issuer.discover(uri);
      final Client client = new Client(issuer, clientId);

      Future<Null> urlLauncher(String url) async {
        if (await canLaunch(url)) {
          await launch(url, forceWebView: true);
        } else {
          throw 'Kunne ikke åpne $url';
        }
      }

      final Authenticator authenticator = Authenticator(
        client,
        scopes: scopes,
        port: 4200,
        urlLancher: urlLauncher,
      );

      print("hello");
      final Credential credential = await authenticator.authorize();
      final TokenResponse tokenResponse = await credential.getTokenResponse();

      closeWebView();

      final List<String> roles = _getRoles(tokenResponse.accessToken);
      final int groupID = _getGroupID(tokenResponse.accessToken);
      await _authenticationService.saveCredentials(
          credential: credential, roles: roles, groupID: groupID);

      _navigatorService.navigateTo(Routes.TabView,
          arguments: globals.KeycloakRoles.reg_employee);
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(ViewState.Idle);
    } else {
      setState(ViewState.Busy);
    }
  }

  dynamic _getJsonContent(String accessToken) {
    JsonWebSignature jws =
        JsonWebSignature.fromCompactSerialization(accessToken);

    JosePayload payload = jws.unverifiedPayload;
    return payload.jsonContent;
  }

  List<String> _getRoles(String accessToken) {
    final jsonContent = _getJsonContent(accessToken);
    dynamic realmAccess = jsonContent['realm_access'];
    List<dynamic> roles = realmAccess['roles'];
    return roles.map((e) => e.toString()).toList();
  }

  int _getGroupID(String accessToken) {
    final jsonContent = _getJsonContent(accessToken);
    if (jsonContent == null) {
      return null;
    }
    return jsonContent['GroupID'];
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}

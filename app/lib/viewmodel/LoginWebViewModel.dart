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

class LoginWebViewModel extends BaseViewModel {
  IAuthenticationService _authenticationService;
  INavigatorService _navigatorService;
  LoginWebViewModel(
    this._authenticationService,
    this._navigatorService,
  ) : super();
  final Uri uri = Uri.parse('${ApiEndpoint.keycloakBaseUrl}');
  final String clientId = 'flutter-app';
  final List<String> scopes = ['openid', 'profile', 'offline_access'];
  void login() async {
    setState(ViewState.Busy);

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

      final Credential credential = await authenticator.authorize();
      final TokenResponse tokenResponse = await credential.getTokenResponse();

      closeWebView();

      final List<String> roles = _getRoles(tokenResponse.accessToken);
      final int groupID = _getGroupID(tokenResponse.accessToken);
      await _authenticationService.saveCredentials(
          credential: credential, roles: roles, groupID: groupID);

      _navigatorService.navigateTo(Routes.TabView,
          arguments: globals.KeycloakRoles.reg_employee);
      // roles.forEach((element) {
      //   if (globals.getRole(element) != null) {
      //     print(globals.getRole(element));
      //   }
      // });

      setState(ViewState.Idle);
    } catch (e) {
      print(e);
    }

    //   return _UserCredentials.withCredentials(
    //       credential: credential, roles: roles, groupID: groupID);
    // } on SocketException catch (_) {
    //   return _UserCredentials.withException(
    //       exception: Exception('Fikk ikke kontakt med serveren'));
    // } on NoSuchMethodError catch (_) {
    //   return _UserCredentials.withException(
    //       exception: Exception('Fikk ikke kontakt med serveren'));
    // } catch (e) {
    //   print('Exception in openKeyCloaklogin:');
    //   print(e);
    //   return _UserCredentials.withException(
    //       exception: Exception('Noe gikk galt'));
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
}

// class _UserCredentials {
//   Credential credential;
//   List<String> roles;
//   int groupID;
//   Exception exception;

//   _UserCredentials.withCredentials({
//     @required this.credential,
//     @required this.roles,
//     @required this.groupID,
//   });

//   _UserCredentials.withException({@required this.exception});
// }

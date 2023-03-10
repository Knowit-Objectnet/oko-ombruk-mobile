import 'package:flutter/material.dart';
import 'dart:io';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jose/jose.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/ui/ui.helper.dart';

import 'package:ombruk/globals.dart' as globals;

class LoginWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        return Scaffold(
          body: Builder(
            // Builder() so that .showSnackbar has a correct Scaffold
            builder: (context) {
              return Center(
                child: RaisedButton(
                  child: Text('Logg inn'),
                  onPressed: () {
                    uiHelper.showLoading(context);
                    _openKeycloakLogin().then(
                      (userCredentials) {
                        if (userCredentials.exception != null) {
                          uiHelper.hideLoading(context);
                          final String exception =
                              userCredentials.exception.toString();
                          uiHelper.showSnackbar(context,
                              exception.substring(11, exception.length));
                        } else {
                          userViewModel
                              .saveCredentials(
                                credential: userCredentials.credential,
                                roles: userCredentials.roles,
                                groupID: userCredentials.groupID,
                              )
                              .then((value) => uiHelper.hideLoading(context));
                        }
                      },
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<_UserCredentials> _openKeycloakLogin() async {
    final Uri uri = Uri.parse('${globals.keycloakBaseUrl}');
    final String clientId = 'flutter-app';
    final List<String> scopes = ['openid', 'profile', 'offline_access'];

    try {
      final Issuer issuer = await Issuer.discover(uri);
      final Client client = new Client(issuer, clientId);

      Future<Null> urlLauncher(String url) async {
        if (await canLaunch(url)) {
          await launch(url, forceWebView: true);
        } else {
          throw 'Kunne ikke ??pne $url';
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

      return _UserCredentials.withCredentials(
          credential: credential, roles: roles, groupID: groupID);
    } on SocketException catch (_) {
      return _UserCredentials.withException(
          exception: Exception('Fikk ikke kontakt med serveren'));
    } on NoSuchMethodError catch (_) {
      return _UserCredentials.withException(
          exception: Exception('Fikk ikke kontakt med serveren'));
    } catch (e) {
      print('Exception in openKeyCloaklogin:');
      print(e);
      return _UserCredentials.withException(
          exception: Exception('Noe gikk galt'));
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
}

class _UserCredentials {
  Credential credential;
  List<String> roles;
  int groupID;
  Exception exception;

  _UserCredentials.withCredentials({
    @required this.credential,
    @required this.roles,
    @required this.groupID,
  });

  _UserCredentials.withException({@required this.exception});
}

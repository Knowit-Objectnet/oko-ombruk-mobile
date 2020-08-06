import 'package:flutter/material.dart';
import 'dart:io';
import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jose/jose.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/models/UserCredentials.dart';

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
                  child: Text("Logg inn"),
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
                              .saveCredentials(userCredentials.credential,
                                  userCredentials.roles)
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

  Future<UserCredentials> _openKeycloakLogin() async {
    final Uri uri = Uri.parse("${globals.keycloakBaseUrl}");
    final String clientId = "flutter-app";
    final List<String> scopes = ["openid", "profile", 'offline_access'];

    try {
      Issuer issuer = await Issuer.discover(uri);
      Client client = new Client(issuer, clientId);

      Future<Null> urlLauncher(String url) async {
        if (await canLaunch(url)) {
          await launch(url, forceWebView: true);
        } else {
          throw 'Could not launch $url';
        }
      }

      var authenticator = Authenticator(
        client,
        scopes: scopes,
        port: 4200,
        urlLancher: urlLauncher,
      );

      Credential credential = await authenticator.authorize();
      TokenResponse tokenResponse = await credential.getTokenResponse();

      closeWebView();

      List<String> roles = _getRoles(tokenResponse.accessToken);
      return UserCredentials.withCredentials(
          credential: credential, roles: roles);
    } on SocketException catch (_) {
      return UserCredentials.withException(
          exception: Exception("Fikk ikke kontakt med serveren"));
    } on NoSuchMethodError catch (_) {
      return UserCredentials.withException(
          exception: Exception("Fikk ikke kontakt med serveren"));
    } catch (e) {
      return UserCredentials.withException(
          exception: Exception("Noe gikk galt"));
    }
  }

  List<String> _getRoles(String accessToken) {
    JsonWebSignature jws =
        JsonWebSignature.fromCompactSerialization(accessToken);

    JosePayload payload = jws.unverifiedPayload;
    dynamic jsonContent = payload.jsonContent;
    dynamic realmAccess = jsonContent['realm_access'];
    List<dynamic> roles = realmAccess['roles'];
    return roles.map((e) => e.toString()).toList();
  }
}

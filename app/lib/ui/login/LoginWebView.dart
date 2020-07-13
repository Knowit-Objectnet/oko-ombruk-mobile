import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/models/UserCredentials.dart';
import 'package:ombruk/repositories/UserRepository.dart';

import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:jose/jose.dart';

import 'package:ombruk/globals.dart' as globals;

class LoginWebView extends StatelessWidget {
  final UserRepository userRepository;
  final storage = FlutterSecureStorage();

  LoginWebView({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Logg inn"),
          onPressed: () => authKeycloak().then((userCredentials) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLogIn(userCredentials: userCredentials));
          }),
        ),
      ),
    );
  }

  Future<UserCredentials> authKeycloak() async {
    final Uri uri = Uri.parse("${globals.keycloakBaseUrl}");
    final String clientId = "flutter-app";
    final List<String> scopes = ["openid", "profile"];

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

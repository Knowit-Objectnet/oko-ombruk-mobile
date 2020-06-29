import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/resources/UserRepository.dart';

import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginWebView extends StatelessWidget {
  final UserRepository userRepository;
  final storage = FlutterSecureStorage();

  LoginWebView({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    authKeycloak().then((value) {
      Credential c = value is Credential ? value : null;
      Exception e = value is Exception ? value : null;
      BlocProvider.of<AuthenticationBloc>(context)
          .add(AuthenticationLoggedIn(credential: c, exception: e));
    });
    return Scaffold(
      body: Center(
        child: Text("Venter på keyclock..."),
      ),
    );
  }

  Future<dynamic> authKeycloak() async {
    final Uri uri =
        Uri.parse("https://keycloak.oko.knowit.no:8443/auth/realms/staging");
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
      closeWebView();
      return credential;
    } on SocketException catch (e) {
      print(e);
    } catch (e) {
      print(e);
      return Exception("Unknown exception");
    }
  }
}

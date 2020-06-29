import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/resources/UserRepository.dart';

import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ombruk/blocs/AuthenticationBloc.dart';

class LoginWebView extends StatelessWidget {
  final UserRepository userRepository;

  LoginWebView({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    authKeycloak().then((value) => BlocProvider.of<AuthenticationBloc>(context)
        .add(AuthenticationLoggedIn(credential: value)));
    return Scaffold(
      body: Center(
        child: Text("Venter på keyclock..."),
      ),
    );
  }

  Future<Credential> authKeycloak() async {
    final Uri uri =
        Uri.parse("https://keycloak.oko.knowit.no:8443/auth/realms/staging");
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
    return credential;
  }
}

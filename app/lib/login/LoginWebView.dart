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

  // @override
  // void initState() {
  //   authenticate().then((value) => setState(() {
  //         // _userInfo = value;
  //         Navigator.of(context).pushReplacementNamed('/home');
  //       }));

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    authKeycloak().then((UserInfo value) =>
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationLoggedIn(token: value.toString())));
    return Scaffold(
      body: Center(
        child: Text("Venter på keyclock..."),
      ),
    );
  }

  Future<UserInfo> authKeycloak() async {
    final Uri uri =
        Uri.parse("https://keycloak.oko.knowit.no:8443/auth/realms/staging");
    final String clientId = "flutter-app";
    final List<String> scopes = ["openid", "profile"];

    // create the client
    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clientId);

    // create a function to open a browser with an url
    Future<Null> urlLauncher(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    // create an authenticator
    var authenticator = new Authenticator(
      client,
      scopes: scopes,
      port: 4200,
      urlLancher: urlLauncher,
    );

    // starts the authentication
    Credential credential = await authenticator.authorize();
    // print("credential.refreshToken: " + credential.refreshToken);
    // print("credential.idToken: " + credential.idToken.toCompactSerialization());

    // Stream<Exception> x =
    //     credential.validateToken(validateClaims: true, validateExpiry: true);
    // await for (Exception e in x) {
    //   print("Exception e: " + e.toString());
    // }

    // TokenResponse tokens = await credential.getTokenResponse();

    // print("Credentials: " + tokens.toString());

    // close the webview when finished
    closeWebView();

    // TODO return token instead
    return await credential.getUserInfo();
  }
}

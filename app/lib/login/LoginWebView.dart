import 'package:flutter/material.dart';

import 'package:openid_client/openid_client.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginWebView extends StatefulWidget {
  @override
  _LoginWebViewState createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  @override
  void initState() {
    authenticate(
        Uri.parse(
            "http://ombruk-ecs-public-staging-85208200.eu-central-1.elb.amazonaws.com:8080/auth/realms/staging"),
        "flutter-app",
        [
          "openid",
          "profile"
        ]).then((value) => print("User info: " + value.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("..")));
  }

  Future<UserInfo> authenticate(
      Uri uri, String clientId, List<String> scopes) async {
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

    // close the webview when finished
    closeWebView();

    // return the user info
    return await credential.getUserInfo();
  }
}

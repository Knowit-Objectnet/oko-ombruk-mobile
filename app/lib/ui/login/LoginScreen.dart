import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String _usernameErrorText;
  String _passwordErrorTetx;
  bool _hidePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('REIR', style: TextStyle(fontSize: 28))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
              child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: 'Brukernavn',
                      icon: Icon(Icons.person_outline),
                      errorText: _usernameErrorText))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Passord',
                        icon: Icon(Icons.lock_outline),
                        errorText: _passwordErrorTetx),
                    obscureText: _hidePassword,
                  ),
                  Positioned(
                    child: GestureDetector(
                      child: Icon(Icons.remove_red_eye),
                      onTap: () => setState(() {
                        _hidePassword = !_hidePassword;
                      }),
                    ),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: _login,
              child: Text('Logg inn'),
            ),
          )
        ],
      ),
    ));
  }

  void _login() {
    // TODO: Login, auth og sånt

    // If auth success:
    Navigator.of(context).pushReplacementNamed('/home');
  }
}

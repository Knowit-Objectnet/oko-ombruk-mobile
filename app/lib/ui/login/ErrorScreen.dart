import 'package:flutter/material.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:provider/provider.dart';

class ErrorScreen extends StatelessWidget {
  final Exception exception;

  ErrorScreen({Key key, this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorText =
        exception.toString().substring(11); // Substring removes 'Exception: '
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(errorText),
          RaisedButton(
            child: Text("OK"),
            onPressed: () =>
                // Wipe credentials on error, could be done better
                Provider.of<UserViewModel>(context).requestLogOut(),
          )
        ],
      )),
    );
  }
}

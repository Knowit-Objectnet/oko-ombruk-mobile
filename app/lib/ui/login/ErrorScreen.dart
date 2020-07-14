import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';

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
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationStarted()),
          )
        ],
      )),
    );
  }
}

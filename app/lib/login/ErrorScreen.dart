import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';

class ErrorScreen extends StatelessWidget {
  final Exception exception;

  ErrorScreen({Key key, this.exception}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String errorText;
    if (exception == null) {
      return Text("");
    }
    if (exception is SocketException) {
      errorText = "Fikk ikke kontakt med Keycloak serveren";
    }
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(errorText ?? 'Noe gikk galt'),
          RaisedButton(
            child: Text("Prøv igjen"),
            onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationStarted()),
          )
        ],
      )),
    );
  }
}

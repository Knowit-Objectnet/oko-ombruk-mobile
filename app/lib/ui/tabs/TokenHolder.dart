import 'package:flutter/material.dart';

class TokenHolder extends InheritedWidget {
  final String token;

  const TokenHolder({@required this.token, @required Widget child})
      : assert(child != null),
        super(child: child);

  @override
  bool updateShouldNotify(TokenHolder oldWidget) => oldWidget.token != token;

  static TokenHolder of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TokenHolder>();
  }
}

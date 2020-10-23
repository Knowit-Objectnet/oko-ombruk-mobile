import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/shared/snackbar/SnackbarFactory.dart';

class SnackbarService {
  final INavigatorService _navigatorService;
  SnackbarService(this._navigatorService) {
    _key = _navigatorService.scaffoldKey;
  }
  GlobalKey<ScaffoldState> _key;

  void showSimpleSnackbar(String text) {
    print("hello $_key");
    _key.currentState.showSnackBar(
        SnackBarFactory.create(SnackBarType.Simple, {"text": text}));
  }

  GlobalKey<ScaffoldState> get key => _key;
}

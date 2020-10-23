import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/shared/dialog/DialogFactory.dart';

class DialogService {
  // Function _showDialogListener;
  // Completer _dialogCompleter;

  // void registerDialogListener(Function showDialogListener) {
  //   _showDialogListener = showDialogListener;
  // }

  // Future showDialog() {
  //   _dialogCompleter = Completer();
  //   _showDialogListener();
  //   return _dialogCompleter.future;
  // }

  // void dialogComplete() {
  //   _dialogCompleter.complete();
  //   _dialogCompleter = null;
  // }

  GlobalKey<NavigatorState> _rootKey;
  bool _isLoading = false;

  set rootKey(GlobalKey<NavigatorState> rootKey) => _rootKey = rootKey;

  void showLoading() {
    showDialog(
        context: _rootKey.currentContext,
        builder: (context) => DialogFactory.create(DialogType.Loading),
        barrierDismissible: false);
    _isLoading = true;
  }

  void hideLoading() {
    if (_isLoading) {
      _rootKey.currentState.pop();
      _isLoading = false;
    }
  }
}

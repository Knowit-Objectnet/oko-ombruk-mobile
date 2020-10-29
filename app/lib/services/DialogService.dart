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
  bool _isShowing = false;

  set rootKey(GlobalKey<NavigatorState> rootKey) => _rootKey = rootKey;

  void showLoading() {
    if (!_isShowing) {
      showDialog(
          context: _rootKey.currentContext,
          builder: (context) => DialogFactory.create(DialogType.Loading),
          barrierDismissible: false);
      _isShowing = true;
    }
  }

  void showCustomDialog(dynamic dialog) {
    showDialog(
      context: _rootKey.currentContext,
      builder: (context) => dialog,
    );
  }

  void openDialog(DialogType type) {
    showDialog(
      context: _rootKey.currentContext,
      builder: (context) => DialogFactory.create(type),
    );
  }

  void hideDialog() {
    if (_isShowing) {
      _rootKey.currentState.pop();
      _isShowing = false;
    }
  }

  void hideLoading() => hideDialog();
}

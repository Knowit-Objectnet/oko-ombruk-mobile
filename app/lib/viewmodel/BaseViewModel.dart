import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }

abstract class BaseViewModel extends ChangeNotifier {
  ViewState state;
  BaseViewModel({this.state = ViewState.Idle});

  void setState(ViewState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> init();
}

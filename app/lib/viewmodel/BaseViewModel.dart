import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }

class BaseViewModel extends ChangeNotifier {
  ViewState state;
  BaseViewModel({this.state = ViewState.Idle});

  void setState(ViewState state) {
    this.state = state;
    notifyListeners();
  }
}

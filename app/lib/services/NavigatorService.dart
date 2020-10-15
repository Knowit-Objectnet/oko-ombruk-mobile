import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/app/TabView.dart';

class NavigatorService implements INavigatorService {
  GlobalKey<NavigatorState> _initialKey;
  GlobalKey<NavigatorState> _navigatorKey;

  @override
  void goBack() {
    _navigatorKey.currentState.pop();
  }

  @override
  void navigateTo(String routeName, {Object arguments}) {
    if (_navigatorKey != null) {
      _navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
    } else {
      assert(arguments != null);
      _initialKey.currentState
          .push(MaterialPageRoute(builder: (_) => TabView(arguments)));
    }
  }

  @override
  void onTabChanged(GlobalKey<NavigatorState> key) {
    this._navigatorKey = key;
  }

  @override
  set initialKey(GlobalKey<NavigatorState> key) {
    if (_initialKey == null) {
      _initialKey = key;
    }
  }

  @override
  void toInitial() {
    _initialKey.currentState.pop();
  }
}

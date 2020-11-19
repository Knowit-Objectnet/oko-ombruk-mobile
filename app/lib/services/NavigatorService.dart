import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/app/App.dart';

class NavigatorService implements INavigatorService {
  static GlobalKey<NavigatorState> _initialKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> _navigatorKey;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void goBack() {
    print(_navigatorKey);
    if (!_navigatorKey.currentState.canPop()) {
      print("Tried popping root!");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      }
      return;
    }
    _navigatorKey.currentState.pop();
    _navigatorKey.currentState.popUntil((route) {
      print(route.settings.name);
      return true;
    });
  }

  @override
  void navigateTo(String routeName, {Object arguments}) {
    if (_navigatorKey != null) {
      _navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
    } else {
      _initialKey.currentState
          .pushReplacementNamed(routeName, arguments: arguments);
    }
  }

  @override
  void onTabChanged(GlobalKey<NavigatorState> key) {
    this._navigatorKey = key;
  }

  @override
  void toInitial() {
    _navigatorKey = null;
    _initialKey.currentState.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => App()), (route) => route == null);
  }

  @override
  GlobalKey<NavigatorState> get initialKey => _initialKey;

  void popUntilEquals(String routeName) {
    print(routeName);
    _navigatorKey.currentState.popUntil((route) {
      print(route);
      print(route.settings.name);
      return route.settings.name == routeName;
    });
  }

  void popStack() {
    _navigatorKey.currentState.popUntil((route) => route.isFirst);
  }

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  void navigateAndReplace(String path, {Object arguments}) {
    _navigatorKey.currentState.popAndPushNamed(path, arguments: arguments);
  }
}

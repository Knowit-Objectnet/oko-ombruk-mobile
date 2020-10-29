import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class INavigatorService {
  void navigateTo(String path, {Object arguments});

  void goBack();

  void toInitial();

  void onTabChanged(GlobalKey<NavigatorState> key);

  void popStack();

  void popUntilEquals(String routeName);

  void navigateAndReplace(String path, {Object arguments});

  GlobalKey<NavigatorState> get initialKey;
  GlobalKey<ScaffoldState> get scaffoldKey;
}

import 'package:flutter/widgets.dart';

abstract class INavigatorService {
  void navigateTo(String path, {Object arguments});

  void goBack();

  void toInitial();

  void onTabChanged(GlobalKey<NavigatorState> key);

  GlobalKey<NavigatorState> get initialKey;
}

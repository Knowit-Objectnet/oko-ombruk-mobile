

import 'package:flutter/widgets.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';

class NavigatorService implements INavigatorService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  bool goBack() {
    navigatorKey.currentState.pop();
  }

  @override
  Future navigateTo(String routeName) {
    navigatorKey.currentState.pushNamed(routeName);
  }


}
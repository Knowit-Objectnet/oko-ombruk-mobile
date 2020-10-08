///
/// App
///

import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/ui/app/TitleBar.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/ui/App/AppDrawer.dart';
import 'package:ombruk/ui/app/AppRouter.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/ui/SplashScreen.dart';
import 'package:ombruk/ui/login/LoginWebView.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  // App router
  AppRouter router = serviceLocator<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, UserViewModel userViewModel, widget) {
      // TODO support.knowit.no/browse/OKO-405
      if (!userViewModel.isLoaded) {
        return SplashScreen();
      }

      // TODO support.knowit.no/browse/OKO-406
      if (userViewModel.accessToken == null) {
        return LoginWebView();
      }

      // Main view
      else {
        print("Login finished");
        print(userViewModel.getRole());
        print(router == null);
        print(router.route == null);
        router.route = router.routes[userViewModel.getRole()];
        print(router.key);
        print(router.route.title);
        return _appView();
      }
    });
  }

  // App view
  Widget _appView() => Scaffold(
      key: router.key,
      // App bar
      appBar: TitleBar(),
      // Body with safe area
      body: SafeArea(
          // Indexed stack to retain view state after navigation
          child: IndexedStack(
        index: router.route.index,
        children: router.route.widgets,
      )),
      // Side menu drawer
      drawer: AppDrawer(),
      // Navigation bar
      bottomNavigationBar: _navigationBar());

  // Navigation bar
  Widget _navigationBar() {
    // Return bar if route has navigation
    return (router.route.navigation)
        ? BottomNavigationBar(
            backgroundColor: customColors.osloDarkBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            // Change current index on tap
            onTap: (index) => {
              setState(() {
                router.route.index = index;
              })
            },
            currentIndex: router.route.index,
            items: router.route.navItems,
          )
        : null;
  }
}

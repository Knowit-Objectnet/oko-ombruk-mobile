import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/AuthRouter.dart';

import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/businessLogic/CalendarViewModel.dart';
import 'package:ombruk/businessLogic/PartnerViewModel.dart';
import 'package:ombruk/businessLogic/StationViewModel.dart';
import 'package:ombruk/businessLogic/PickupViewModel.dart';

void main() {
  setupServiceLocator();
  runApp(
    // Top-level Provider so it is accessible everywhere
    // Why do you ask? Because if we try to access them in a new route, for exmaple with
    // Navigator.of(context).push(...) it cannot be found/accessed, it just throws an
    // error of the type 'Error: Could not find the correct Provider<..> above this Consumer<..>'
    // They can be moved futher down the tree if you find a solution to this issue.
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserViewModel>(
          create: (context) => serviceLocator<UserViewModel>(),
        ),
        ChangeNotifierProvider<CalendarViewModel>(
          create: (context) => serviceLocator<CalendarViewModel>(),
        ),
        ChangeNotifierProvider<PartnerViewModel>(
          create: (context) => serviceLocator<PartnerViewModel>(),
        ),
        ChangeNotifierProvider<StationViewModel>(
          create: (context) => serviceLocator<StationViewModel>(),
        ),
        ChangeNotifierProvider<PickupViewModel>(
          create: (context) => serviceLocator<PickupViewModel>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REIR',
      theme: ThemeData(
        fontFamily: 'OsloSansOffice',
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthRouter(),
    );
  }
}

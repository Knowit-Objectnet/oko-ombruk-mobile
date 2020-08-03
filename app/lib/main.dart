import 'package:flutter/material.dart';
import 'package:ombruk/AuthRouter.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator();
  runApp(
    // Top-level Provider so it is accessible everywhere
    ChangeNotifierProvider<UserViewModel>(
      create: (context) => serviceLocator<UserViewModel>(),
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

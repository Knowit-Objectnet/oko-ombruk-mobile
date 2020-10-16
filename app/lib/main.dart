import 'package:flutter/material.dart';
import 'package:ombruk/di/GlobalProviders.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/ui/app/App.dart';

void main() {
  runApp(
    // Top-level Provider so it is accessible everywhere
    // Why do you ask? Because if we try to access them in a new route, for exmaple with
    // Navigator.of(context).push(...) it cannot be found/accessed, it just throws an
    // error of the type 'Error: Could not find the correct Provider<..> above this Consumer<..>'
    // They can be moved futher down the tree if you find a solution to this issue.
    MultiProvider(
      providers: globalProviders,
      child: Reir(),
    ),
  );
}

class Reir extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    INavigatorService _navigatorService = Provider.of(context);
    return MaterialApp(
      title: 'REIR',
      navigatorKey: _navigatorService.initialKey,
      theme: ThemeData(
        fontFamily: 'OsloSansOffice',
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: App(),
    );
  }
}

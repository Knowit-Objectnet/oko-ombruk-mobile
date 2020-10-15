import 'package:flutter/material.dart';
import 'package:ombruk/Routes.dart';
import 'package:ombruk/ui/app/TabView.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("${settings.name} ${settings.arguments}");
    switch (settings.name) {
      case Routes.TabView:
        return MaterialPageRoute(builder: (_) => TabView(settings.arguments));
      case Routes.KalenderView:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case Routes.VarslerView:
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case Routes.StatistikkView:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text("Statistikk"),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Text("Route not defined"),
          ),
        );
    }
  }
}

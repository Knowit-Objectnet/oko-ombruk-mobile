import 'package:flutter/material.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/ui/app/App.dart';
import 'package:ombruk/ui/app/TabView.dart';
import 'package:ombruk/ui/calendar/CalendarView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';
import 'package:ombruk/ui/weightreport/WeightReportView.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.TabView:
        return MaterialPageRoute(builder: (_) => TabView());
      case Routes.KalenderView:
        return MaterialPageRoute(builder: (_) => CalendarView());
      case Routes.VarslerView:
        return MaterialPageRoute(builder: (_) => NotificationView());
      case Routes.StatistikkView:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text("Statistikk"),
          ),
        );
      case Routes.WeightReportView:
        return MaterialPageRoute(builder: (_) => WeightReportView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Text("Route not defined"),
          ),
        );
    }
  }
}

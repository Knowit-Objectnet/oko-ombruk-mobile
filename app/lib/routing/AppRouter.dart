import 'package:flutter/material.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/routing/arguments/CalendarEventScreenArgs.dart';
import 'package:ombruk/ui/app/TabView.dart';
import 'package:ombruk/ui/calendar/view/CalendarView.dart';
import 'package:ombruk/ui/calendar/view/CreateCalendarEventScreen.dart';
import 'package:ombruk/ui/calendar/view/CreateOccurrenceScreen.dart';
import 'package:ombruk/ui/login/LoginWebView.dart';
import 'package:ombruk/ui/message/MessageScreen.dart';
import 'package:ombruk/ui/myPage/MyPageView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';
import 'package:ombruk/ui/partner/NewPartnerView.dart';
import 'package:ombruk/ui/pickup/AddExtraPickupView.dart';
import 'package:ombruk/ui/station/NewStationView.dart';
import 'package:ombruk/ui/weightreport/WeightReportView.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.TabView:
        return MaterialPageRoute(settings: settings, builder: (_) => TabView());
      case Routes.KalenderView:
        return MaterialPageRoute(
            settings: settings, builder: (_) => CalendarView());
      case Routes.VarslerView:
        return MaterialPageRoute(
            settings: settings, builder: (_) => NotificationView());
      case Routes.CreateOccurenceView:
        return MaterialPageRoute(
            settings: settings, builder: (_) => CreateOccurenceView());
      case Routes.CreateCalendarEventView:
        assert(settings.arguments is CalendarEventScreenArgs);
        CalendarEventScreenArgs args = settings.arguments;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => CreateCalendarEvent(
                station: args.station, partner: args.partner));
      case Routes.MinSideView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MyPageView(),
        );

      case Routes.LoginView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginWebView(),
        );

      case Routes.AddExtraPickupView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AddExtraPickupView(),
        );

      case Routes.MessageView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MessageView(),
        );
      case Routes.NewPartnerView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NewPartnerView(),
        );

      case Routes.NewStationView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NewStationView(),
        );

      case Routes.StatistikkView:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Container(
            child: Text("Statistikk"),
          ),
        );
      case Routes.WeightReportView:
        return MaterialPageRoute(builder: (_) => WeightReportView());
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Text("Route not defined"),
          ),
        );
    }
  }
}

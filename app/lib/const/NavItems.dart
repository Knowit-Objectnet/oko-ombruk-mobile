import 'package:flutter/material.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/ui/app/NavItem.dart';

abstract class NavItems {
  static NavItem varsler = NavItem(
    "Varsler",
    Icons.notifications,
    GlobalKey<NavigatorState>(debugLabel: "partnerVarsler"),
    Routes.VarslerView,
  );

  static NavItem kalender = NavItem(
    "Kalender",
    Icons.calendar_today,
    GlobalKey<NavigatorState>(debugLabel: "partnerKalender"),
    Routes.KalenderView,
  );

  static NavItem vekt = NavItem(
    "Weight",
    Icons.emoji_transportation,
    GlobalKey<NavigatorState>(debugLabel: "partnerWeight"),
    Routes.WeightReportView,
  );

  static NavItem statistikk = NavItem(
    "Statistikk",
    Icons.insert_chart,
    GlobalKey<NavigatorState>(debugLabel: "regStatistikk"),
    Routes.StatistikkView,
  );
}

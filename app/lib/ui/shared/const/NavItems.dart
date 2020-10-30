import 'package:flutter/material.dart';
import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/model/NavItem.dart';

abstract class NavItems {
  static NavItem varsler = NavItem(
    "Varsler",
    ImageIcon(
      AssetImage("assets/icons/${CustomIcons.clock}"),
      color: CustomColors.osloWhite,
      size: 25,
    ),
    GlobalKey<NavigatorState>(debugLabel: "VarslerNavigator"),
    Routes.VarslerView,
  );

  static NavItem kalender = NavItem(
    "Kalender",
    ImageIcon(
      AssetImage("assets/icons/${CustomIcons.calendar}"),
      color: CustomColors.osloWhite,
      size: 25,
    ),
    GlobalKey<NavigatorState>(debugLabel: "KalenderNavigator"),
    Routes.KalenderView,
  );

  static NavItem vekt = NavItem(
    "Weight",
    ImageIcon(
      AssetImage("assets/icons/${CustomIcons.weight}"),
      color: CustomColors.osloWhite,
      size: 25,
    ),
    GlobalKey<NavigatorState>(debugLabel: "PartnerNavigator"),
    Routes.WeightReportView,
  );

  static NavItem statistikk = NavItem(
    "Statistikk",
    ImageIcon(
      AssetImage("assets/icons/${CustomIcons.statistics}"),
      color: CustomColors.osloWhite,
      size: 25,
    ),
    GlobalKey<NavigatorState>(debugLabel: "StatistikkNavigator"),
    Routes.StatistikkView,
  );
}

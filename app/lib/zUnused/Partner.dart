///
/// View reference for the partner role
/// KeycloakRoles.partner
///

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/calendar/CalendarView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';
import 'package:ombruk/zUnused/AppView.dart';

AppView partnerView = AppView(defaultIndex: 1, widgets: <Widget>[
  NotificationView(),
  CalendarView(),
  Container()
], navItems: [
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications),
    title: Text("Varsler"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    title: Text("Kalender"),
  ),
  BottomNavigationBarItem(
      icon: Icon(Icons.insert_chart), title: Text("Statistikk"))
]);

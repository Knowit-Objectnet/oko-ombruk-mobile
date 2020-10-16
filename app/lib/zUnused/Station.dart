///
/// View reference for the station role
/// KeycloakRoles.reuse_station
///

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/App/AppView.dart';
import 'package:ombruk/ui/calendar/CalendarView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';

AppView stationView = AppView(defaultIndex: 0, widgets: [
  CalendarView(),
  NotificationView(),
], navItems: [
  BottomNavigationBarItem(
    icon: Icon(Icons.calendar_today),
    title: Text("Kalender"),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.notifications),
    title: Text("Varsler"),
  )
]);

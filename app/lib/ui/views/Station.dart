///
/// View reference for the station role
/// KeycloakRoles.reuse_station
/// 

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/App/AppView.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';

AppView stationView = AppView(
  defaultIndex: 0,
  widgets: [
    CalendarScreen(),
    NotificationScreen(),
  ],
  navItems: [
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text("Kalender"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      title: Text("Varsler"),
    )
  ]
);

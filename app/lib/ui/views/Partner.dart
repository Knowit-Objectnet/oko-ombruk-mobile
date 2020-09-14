///
/// View reference for the partner role
/// KeycloakRoles.partner
/// 

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/App/AppView.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';

AppView partnerView = AppView(
  defaultIndex: 1,
  widgets: <Widget>[
    NotificationScreen(),
    CalendarScreen(),
    Container()
  ],
  navItems: [
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      title: Text("Varsler"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      title: Text("Kalender"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.insert_chart),
      title: Text("Statistikk")
    )
  ]
);

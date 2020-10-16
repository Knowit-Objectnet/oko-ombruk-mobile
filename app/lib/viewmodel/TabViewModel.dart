import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/app/AppView2.dart';
import 'package:ombruk/ui/app/NavItem.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/globals.dart' as globals;

class TabViewModel extends BaseViewModel {
  INavigatorService _navigatorService;
  final globals.KeycloakRoles _role;
  int _index;
  TabViewModel(this._role, this._navigatorService) {
    print("Model $_role");
    _index = tabItems[_role].defaultIndex;
    _navigatorService
        .onTabChanged(tabItems[_role].navItems[_index].navigatorKey);
  }
  static final Map<KeycloakRoles, AppView2> tabItems = {
    KeycloakRoles.partner: AppView2(
      defaultIndex: 1,
      navItems: [
        NavItem(
            "Varsler",
            Icons.notifications,
            GlobalKey<NavigatorState>(debugLabel: "partnerVarsler"),
            "/varsler"),
        NavItem(
            "Kalender",
            Icons.calendar_today,
            GlobalKey<NavigatorState>(debugLabel: "partnerKalender"),
            "/kalender"),
        NavItem(
            "Statistikk",
            Icons.insert_chart,
            GlobalKey<NavigatorState>(debugLabel: "partnerStatistikk"),
            "/statistikk"),
        // NavItem(
        //   "Weight",
        //   Icons.emoji_transportation,
        //   GlobalKey<NavigatorState>(debugLabel: "partnerWeight"),
        //   "/weight",
        // )
      ],
    ),
    KeycloakRoles.reg_employee: AppView2(
      defaultIndex: 1,
      navItems: [
        NavItem(
          "Varsler",
          Icons.notifications,
          GlobalKey<NavigatorState>(debugLabel: "regVarsler"),
          "/varsler",
        ),
        NavItem(
          "Kalender",
          Icons.calendar_today,
          GlobalKey<NavigatorState>(debugLabel: "regKalender"),
          "/kalender",
        ),
        NavItem(
            "Statistikk",
            Icons.insert_chart,
            GlobalKey<NavigatorState>(debugLabel: "regStatistikk"),
            "/statistikk"),
      ],
    ),
    KeycloakRoles.reuse_station: AppView2(
      defaultIndex: 1,
      navItems: [
        NavItem("Kalender", Icons.calendar_today, GlobalKey<NavigatorState>(),
            "/kalender"),
        NavItem("Varsler", Icons.notifications, GlobalKey<NavigatorState>(),
            "/varsler"),
        NavItem("Weight", Icons.emoji_transportation,
            GlobalKey<NavigatorState>(debugLabel: "partnerWeight"), "/weight")
      ],
    ),
  };
  AppView2 get view => tabItems[_role];
  // Map<globals.KeycloakRoles, AppView> _routes = Map.from({
  //   globals.KeycloakRoles.partner: partnerView,
  //   globals.KeycloakRoles.reg_employee: employeeView,
  //   globals.KeycloakRoles.reuse_station: stationView,
  // });

  // AppView get view => AppView(defaultIndex: 1, key: key, widgets: [
  //       NotificationScreen(),
  //       CalendarScreen(globalKey: key),
  //       Container()
  //     ], navItems: [
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.notifications),
  //         title: Text("Varsler"),
  //       ),
  //       BottomNavigationBarItem(
  //         icon: Icon(Icons.calendar_today),
  //         title: Text("Kalender"),
  //       ),
  //       BottomNavigationBarItem(
  //           icon: Icon(Icons.insert_chart), title: Text("Statistikk"))
  //     ], actionItems: [
  //       ActionItem(
  //           icon: Icon(Icons.list),
  //           callback: (actionKey) {
  //             // Toggle calendar view
  //             key.currentState.toggleCalendar();

  //             // Change icon
  //             Icon icon = Icon(key.currentState.verticalCalendar
  //                 ? Icons.list
  //                 : Icons.calendar_today);
  //             actionKey.currentState.setIcon(icon);
  //           }),
  //       ActionItem(
  //           icon: Icon(Icons.add),
  //           callback: (actionKey) {
  //             // Push screen
  //             Navigator.push(
  //                 actionKey.currentContext,
  //                 MaterialPageRoute(
  //                     builder: (context) => AddExtraPickupScreen()));
  //           })
  //     ]);
  int get index => _index;

  void onTabChanged(int index) {
    _navigatorService.onTabChanged(view.navItems[index].navigatorKey);
    _index = index;
    notifyListeners();
  }
}

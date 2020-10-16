import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/app/AppView.dart';
import 'package:ombruk/ui/app/NavItem.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class TabViewModel extends BaseViewModel {
  INavigatorService _navigatorService;
  IAuthenticationService _authenticationService;
  int _index;
  KeycloakRoles _role;
  TabViewModel(this._navigatorService, this._authenticationService) {
    this._role = getRole(_authenticationService.userModel.roles
        .firstWhere((role) => getRole(role) != null, orElse: () => null));
    _index = tabItems[_role].defaultIndex;
    _navigatorService
        .onTabChanged(tabItems[_role].navItems[_index].navigatorKey);
  }
  static final Map<KeycloakRoles, AppView> tabItems = {
    KeycloakRoles.partner: AppView(
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
    KeycloakRoles.reg_employee: AppView(
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
    KeycloakRoles.reuse_station: AppView(
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
  AppView get view => tabItems[_role];
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

// ///
// /// View reference for the employee role
// /// KeycloakRoles.reg_employee
// ///

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:ombruk/models/ActionItem.dart';
// import 'package:ombruk/services/serviceLocator.dart';
// import 'package:ombruk/ui/App/AppView.dart';
// import 'package:ombruk/ui/app/AppRouter.dart';
// import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
// import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
// import 'package:ombruk/ui/tabs/stasjonComponents/AddExtraPickupScreen.dart';

// // AppRouter
// AppRouter router = serviceLocator<AppRouter>();

// // Calendar key reference
// GlobalKey<CalendarScreenConsumedState> key = GlobalKey();

// AppView employeeView = AppView(defaultIndex: 1, key: key, widgets: [
//   NotificationScreen(),
//   CalendarScreen(globalKey: key),
//   Container()
// ], navItems: [
//   BottomNavigationBarItem(
//     icon: Icon(Icons.notifications),
//     title: Text("Varsler"),
//   ),
//   BottomNavigationBarItem(
//     icon: Icon(Icons.calendar_today),
//     title: Text("Kalender"),
//   ),
//   BottomNavigationBarItem(
//       icon: Icon(Icons.insert_chart), title: Text("Statistikk"))
// ], actionItems: [
//   ActionItem(
//       icon: Icon(Icons.list),
//       callback: (actionKey) {
//         // Toggle calendar view
//         key.currentState.toggleCalendar();

//         // Change icon
//         Icon icon = Icon(key.currentState.verticalCalendar
//             ? Icons.list
//             : Icons.calendar_today);
//         actionKey.currentState.setIcon(icon);
//       }),
//   ActionItem(
//       icon: Icon(Icons.add),
//       callback: (actionKey) {
//         // Push screen
//         Navigator.push(actionKey.currentContext,
//             MaterialPageRoute(builder: (context) => AddExtraPickupScreen()));
//       })
// ]);

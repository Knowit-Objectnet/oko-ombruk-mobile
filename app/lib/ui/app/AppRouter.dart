// ///
// /// App router for view/widget state handling
// /// Description: Used when changeing current view.
// ///

// import 'package:flutter/material.dart';
// import 'package:ombruk/services/serviceLocator.dart';
// import 'package:ombruk/ui/App/AppView.dart';
// import 'package:ombruk/businessLogic/UserViewModel.dart';
// import 'package:ombruk/globals.dart' as globals;
// import 'package:ombruk/ui/views/Employee.dart';
// import 'package:ombruk/ui/views/Partner.dart';
// import 'package:ombruk/ui/views/Station.dart';

// class AppRouter {
//   // Current route
//   AppView route = partnerView;

//   // Retains the scaffold key state
//   GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

//   // Auth
//   UserViewModel _userViewModel = serviceLocator<UserViewModel>();
//   Map<globals.KeycloakRoles, AppView> routes;

//   AppRouter() {

//     print("user view model");
//     print(_userViewModel);
//     // Authentication routes
//     routes = {
//       globals.KeycloakRoles.partner: partnerView,
//       globals.KeycloakRoles.reg_employee: employeeView,
//       globals.KeycloakRoles.reuse_station: stationView,
//     };

//     // Listen for authentication change to change app route
//     _userViewModel.addListener(() {
//       var role = _userViewModel.getRole(); // Get updated role
//       route = routes[role]; // Set route
//     });
//   }

//   // Items getter
//   //get items => route.items;
// }

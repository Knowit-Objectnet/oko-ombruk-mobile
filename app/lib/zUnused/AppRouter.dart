///
/// App router for view/widget state handling
/// Description: Used when changeing current view.
///

import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/zUnused/AppView.dart';
import 'package:ombruk/zUnused/Partner.dart';

class AppRouter {
  // Current route
  AppView route; // = partnerView;

  // Retains the scaffold key state
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  // Auth
  //UserViewModel _userViewModel; // = serviceLocator<UserViewModel>();
  Map<globals.KeycloakRoles, AppView> routes;

  AppRouter() {
    print("user view model");
    // Authentication routes
    routes = {
      globals.KeycloakRoles.partner: null, //partnerView,
      globals.KeycloakRoles.reg_employee: null, //employeeView,
      globals.KeycloakRoles.reuse_station: null, // stationView,
    };

    // Listen for authentication change to change app route
    // _userViewModel.addListener(() {
    //   var role = _userViewModel.getRole(); // Get updated role
    //   route = routes[role]; // Set route
    // });
  }

  // Items getter
  //get items => route.items;
}

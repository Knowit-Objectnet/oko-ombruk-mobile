// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:ombruk/businessLogic/UserViewModel.dart';

// import 'package:ombruk/ui/SplashScreen.dart';
// import 'package:ombruk/ui/login/ErrorScreen.dart';
// import 'package:ombruk/ui/login/LoginWebView.dart';
// import 'package:ombruk/ui/tabs/TabsScreenPartner.dart';
// import 'package:ombruk/ui/tabs/TabsScreenReg.dart';
// import 'package:ombruk/ui/tabs/TabsScreenStasjon.dart';

// import 'package:ombruk/globals.dart';

// class AuthRouter extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, UserViewModel userViewModel, widget) {
//         if (!userViewModel.isLoaded) {
//           return SplashScreen();
//         }
//         if (userViewModel.accessToken == null) {
//           return LoginWebView();
//         }
//         // Has accessToken => show tabs
//         switch (userViewModel.getRole()) {
//           case KeycloakRoles.reg_employee:
//             return TabsScreenReg();
//           case KeycloakRoles.partner:
//             return TabsScreenPartner();
//           case KeycloakRoles.reuse_station:
//             return TabsScreenStasjon();
//           case KeycloakRoles.offline_access:
//             return ErrorScreen(exception: Exception('Du har ikke en rolle'));
//           case KeycloakRoles.uma_authorization:
//             return ErrorScreen(exception: Exception('Du har ikke en rolle'));
//           default:
//             return ErrorScreen(exception: Exception('Ukjent rolle'));
//         }
//       },
//     );
//   }
// }

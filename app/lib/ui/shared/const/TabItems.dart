import 'package:ombruk/globals.dart';
import 'package:ombruk/ui/shared/const/NavItems.dart';
import 'package:ombruk/ui/shared/model/AppView.dart';

abstract class TabItems {
  static final Map<KeycloakRoles, AppView> tabItems = {
    KeycloakRoles.partner: AppView(
      defaultIndex: 1,
      navItems: [
        NavItems.varsler,
        NavItems.kalender,
        NavItems.vekt,
      ],
    ),
    KeycloakRoles.reg_employee: AppView(
      defaultIndex: 1,
      navItems: [
        NavItems.varsler,
        NavItems.kalender,
        NavItems.statistikk,
      ],
    ),
    KeycloakRoles.reuse_station: AppView(
      defaultIndex: 1,
      navItems: [
        NavItems.kalender,
        NavItems.varsler,
        NavItems.vekt,
      ],
    ),
  };
}

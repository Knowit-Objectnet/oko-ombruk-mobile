import 'package:flutter/widgets.dart';

class NavItem {
  final String label;
  final IconData iconData;
  final GlobalKey navigatorKey;
  final String routeName;
  NavItem(this.label, this.iconData, this.navigatorKey, this.routeName);
}

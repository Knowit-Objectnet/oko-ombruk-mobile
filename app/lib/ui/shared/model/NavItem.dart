import 'package:flutter/widgets.dart';

class NavItem {
  final String label;
  final dynamic icon;
  final GlobalKey navigatorKey;
  final String routeName;
  NavItem(this.label, this.icon, this.navigatorKey, this.routeName);
}

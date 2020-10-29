import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/shared/model/NavItem.dart';

class AppView {
  final int defaultIndex;
  final List<NavItem> navItems;
  AppView({
    @required this.defaultIndex,
    @required this.navItems,
  });
}

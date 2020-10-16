///
/// App view class
/// Used for defining views used during routing
///

import 'package:flutter/widgets.dart';
import 'package:ombruk/zUnused/ActionItem.dart';

class AppView {
  GlobalKey key; // AppView key
  int defaultIndex; // Initial index
  List<Widget> widgets; // Widget screens
  List<ActionItem> actionItems; // TitleBar action items
  List<BottomNavigationBarItem> navItems; // NavBar items

  // Named constructor
  AppView({
    this.key,
    this.defaultIndex,
    this.widgets,
    this.actionItems,
    this.navItems,
  });

  // Current index setter / getter
  int get index => this.defaultIndex;
  set index(index) => this.defaultIndex = index;

  // Getter for route's to check if view has navigation items
  bool get navigation => (this.navItems.length > 0) ? true : false;

  // Current route's title Text widget.
  Text get title =>
      (this.navItems != null) ? navItems[defaultIndex].title : Text("");
}

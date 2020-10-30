import 'package:flutter/foundation.dart';

class DrawerItem {
  final String icon;
  final String title;
  final Function onTap;
  final bool isSelected;

  DrawerItem({
    @required this.icon,
    @required this.title,
    @required this.onTap,
    @required this.isSelected,
  });
}

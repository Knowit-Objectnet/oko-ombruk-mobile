import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class DrawerButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  final bool isSelected;

  DrawerButton({
    @required this.icon,
    @required this.title,
    @required this.onTap,
    @required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color _color =
        isSelected ? customColors.osloLightBlue : customColors.osloWhite;

    return ListTile(
      leading: customIcons.image(icon, size: 28, color: _color),
      title: Text(title, style: TextStyle(color: _color)),
      onTap: () {
        Navigator.pop(context); // Closes the drawer
        onTap();
      },
    );
  }
}

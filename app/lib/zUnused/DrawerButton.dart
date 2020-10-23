import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

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
        isSelected ? CustomColors.osloLightBlue : CustomColors.osloWhite;

    return ListTile(
      leading: CustomIcons.image(icon, size: 28, color: _color),
      title: Text(title, style: TextStyle(color: _color)),
      onTap: () {
        Navigator.pop(context); // Closes the drawer
        onTap();
      },
    );
  }
}

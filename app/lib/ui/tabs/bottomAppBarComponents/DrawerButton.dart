import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class DrawerButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  DrawerButton(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: customIcons.image(icon, size: 28, color: customColors.osloWhite),
      title: Text(title, style: TextStyle(color: customColors.osloWhite)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

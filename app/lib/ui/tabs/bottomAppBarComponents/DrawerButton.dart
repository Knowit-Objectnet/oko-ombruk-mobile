import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

class DrawerButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  DrawerButton(this.icon, this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/icons/$icon',
        color: customColors.osloWhite,
        height: 28,
        width: 28,
      ),
      title: Text(title, style: TextStyle(color: customColors.osloWhite)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

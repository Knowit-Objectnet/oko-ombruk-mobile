import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

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
        color: globals.osloWhite,
        height: 28,
        width: 28,
      ),
      title: Text(title, style: TextStyle(color: globals.osloWhite)),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

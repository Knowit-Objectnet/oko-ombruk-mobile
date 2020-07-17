import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class BottomAppBarButton extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final Function onPressed;

  BottomAppBarButton({
    @required this.icon,
    @required this.isSelected,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          'assets/icons/$icon',
          height: 25,
          width: 25,
          color: isSelected ? globals.osloLightBlue : globals.osloWhite,
        ),
      ),
    );
  }
}

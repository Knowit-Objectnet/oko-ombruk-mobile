import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

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
            icon: customIcons.image(icon,
                size: 25,
                color: isSelected
                    ? customColors.osloLightBlue
                    : customColors.osloWhite)));
  }
}

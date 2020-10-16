import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

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
            icon: CustomIcons.image(icon,
                size: 25,
                color: isSelected
                    ? CustomColors.osloLightBlue
                    : CustomColors.osloWhite)));
  }
}

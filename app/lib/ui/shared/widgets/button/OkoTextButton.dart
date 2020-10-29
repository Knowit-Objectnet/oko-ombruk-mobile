import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class OkoTextButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Widget icon;

  OkoTextButton({
    @required this.onPressed,
    @required this.text,
    @required this.icon,
    this.backgroundColor: CustomColors.osloLightBeige,
    this.iconBackgroundColor = CustomColors.osloGreen,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                color: backgroundColor,
                child: Text(text),
              ),
            ),
            CircleAvatar(
              backgroundColor: iconBackgroundColor,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}

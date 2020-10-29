import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class ContactInfoField extends StatelessWidget {
  final String value;
  final Widget icon;
  final EdgeInsets padding;
  ContactInfoField({
    @required this.value,
    this.icon,
    this.padding = const EdgeInsets.symmetric(vertical: 1),
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        padding: EdgeInsets.all(10),
        color: CustomColors.osloLightBlue,
        child: Row(
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: icon,
              ),
            Text(value),
          ],
        ),
      ),
    );
  }
}

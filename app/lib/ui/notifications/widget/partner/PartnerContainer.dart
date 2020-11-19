import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class PartnerContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final double fractionalWidth;
  PartnerContainer({
    @required this.label,
    this.backgroundColor: CustomColors.osloWhite,
    this.borderColor = Colors.transparent,
    this.fractionalWidth = 0.3,
  });
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: fractionalWidth,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 3,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

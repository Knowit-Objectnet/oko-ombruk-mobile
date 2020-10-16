import 'package:flutter/widgets.dart';

abstract class CustomColors {
  static const Color osloDarkBlue = Color(0xFF2A2859);
  static const Color osloGreen = Color(0xFF43F8B6);
  static const Color osloRed = Color(0xFFFF8274);
  static const Color osloYellow = Color(0xFFF9C66B);
  static const Color osloLightBlue = Color(0xFFB3F5FF);
  static const Color osloLightBeige = Color(0xFFF8F0DD);
  static const Color osloLightGreen = Color(0xFFC7F6C9);
  static const Color osloBlue = Color(0xFF6FE9FF);
  static const Color osloBlack = Color(0xFF2C2C2C);
  static const Color osloDarkBeige = Color(0xFFD0BFAE);
  static const Color osloDarkGreen = Color(0xFF034B45);
  static const Color osloWhite = Color(0xFFFFFFFF);

  static Color partnerColor(String partner) {
    // Hardcoded values for now
    switch (partner) {
      case 'Fretex':
        return osloRed;
      case 'Maritastiftelsen':
        return osloLightBeige;
      case 'Jobben':
        return osloDarkBeige;
      case 'Frigo':
        return osloLightBlue;
      case 'Marita':
        return osloLightGreen;
      case 'Norske Mikrohus':
        return osloLightBeige;
      case 'Circular Ways':
        return osloLightGreen;
      default:
        return osloLightBeige;
    }
  }
}

import 'package:flutter/material.dart';

const Color osloDarkBlue = Color(0xFF2A2859);
const Color osloGreen = Color(0xFF43F8B6);
const Color osloRed = Color(0xFFFF8274);
const Color osloYellow = Color(0xFFF9C66B);
const Color osloLightBlue = Color(0xFFB3F5FF);
const Color osloLightBeige = Color(0xFFF8F0DD);
const Color osloLightGreen = Color(0xFFC7F6C9);
const Color osloBlue = Color(0xFF6FE9FF);
const Color osloBlack = Color(0xFF2C2C2C);
const Color osloDarkBeige = Color(0xFFD0BFAE);
const Color osloDarkGreen = Color(0xFF034B45);
const Color osloWhite = Color(0xFFFFFFFF);

Color partnerColor(String partner) {
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
    default:
      return osloLightBeige;
  }
}

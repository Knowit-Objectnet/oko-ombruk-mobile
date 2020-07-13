import 'package:flutter/material.dart';

final String keycloakBaseUrl =
    'https://keycloak.staging.oko.knowit.no:8443/auth/realms/staging';

final String calendarBaseUrl =
    'https://tcuk58u5ge.execute-api.eu-central-1.amazonaws.com/staging/calendar';

final String weightReportBaseUrl = 'https://example.com';

final Map<int, String> weekdaysShort = {
  1: 'Man',
  2: 'Tir',
  3: 'Ons',
  4: 'Tors',
  5: 'Fre',
  6: 'Lør',
  7: 'Søn'
};

final Map<int, String> weekdaysLong = {
  1: 'Mandag',
  2: 'Tirsdag',
  3: 'Onsdag',
  4: 'Torsdag',
  5: 'Fredag',
  6: 'Lørdag',
  7: 'Søndag'
};

final Map<int, String> months = {
  1: 'Januar',
  2: 'Februar',
  3: 'Mars',
  4: 'April',
  5: 'Mai',
  6: 'Juni',
  7: 'Juli',
  8: 'August',
  9: 'September',
  10: 'Oktober',
  11: 'November',
  12: 'Desember',
};

// The order of the lists are important to match the ID index
final List<String> stations = [
  'Haraldrud',
  'Smestad',
  'Grefsen',
  'Grønmo',
  'Ryen'
];

final List<String> partners = [
  'Fretex',
  'Maritastiftelsen',
  'Jobben',
];

enum KeycloakRoles {
  reg_employee,
  offline_access,
  uma_authorization,
  partner,
  reuse_station
}

final Color osloDarkBlue = Color(0xFF2A2859);
final Color osloGreen = Color(0xFF43F8B6);
final Color osloRed = Color(0xFFFF8274);
final Color osloYellow = Color(0xFFF9C66B);
final Color osloLightBlue = Color(0xFFB3F5FF);
final Color osloLightBeige = Color(0xFFF8F0DD);
final Color osloLightGreen = Color(0xFFC7F6C9);
final Color osloBlue = Color(0xFF6FE9FF);
final Color osloBlack = Color(0xFF2C2C2C);
final Color osloDarkBeige = Color(0xFFD0BFAE);
final Color osloDarkGreen = Color(0xFF034B45);
final Color osloWhite = Color(0xFFFFFFFF);

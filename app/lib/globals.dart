final String keycloakBaseUrl =
    'https://keycloak.staging.oko.knowit.no:8443/auth/realms/staging';

final String baseUrlStripped =
    'tcuk58u5ge.execute-api.eu-central-1.amazonaws.com';

final String requiredPath = '/staging';

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

final Map<int, String> monthsShort = {
  1: 'JAN',
  2: 'FEB',
  3: 'MAR',
  4: 'APR',
  5: 'MAI',
  6: 'JUN',
  7: 'JUL',
  8: 'AUG',
  9: 'SEP',
  10: 'OKT',
  11: 'NOV',
  12: 'DES',
};

enum KeycloakRoles {
  reg_employee,
  offline_access,
  uma_authorization,
  partner,
  reuse_station
}

enum Weekdays { monday, tuesday, wednesday, thursday, friday }

/// Removes the microseconds from [DateTime] so that the backend don't whine
String getDateString(DateTime dateTime) {
  return dateTime?.toIso8601String()?.substring(0, 19);
}

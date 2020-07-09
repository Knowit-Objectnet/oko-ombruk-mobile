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

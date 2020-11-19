import 'package:flutter/foundation.dart';

enum KeycloakRoles {
  reg_employee,
  offline_access,
  uma_authorization,
  partner,
  reuse_station
}

/// returns a value from [globals.KeycloakRoles] or null if no match
KeycloakRoles getRole(String role) {
  if (role == describeEnum(KeycloakRoles.partner)) {
    return KeycloakRoles.partner;
  } else if (role == describeEnum(KeycloakRoles.reg_employee)) {
    return KeycloakRoles.reg_employee;
  } else if (role == describeEnum(KeycloakRoles.reuse_station)) {
    return KeycloakRoles.reuse_station;
  }
  return null;
}

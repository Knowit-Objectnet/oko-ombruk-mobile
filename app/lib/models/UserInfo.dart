import 'package:ombruk/globals.dart';

class UserInfo {
  KeycloakRoles role;
  int groupId;
  UserInfo(this.role, this.groupId) {
    assert(role != null);
    assert(groupId != null);
  }
}

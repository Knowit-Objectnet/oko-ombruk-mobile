import 'package:meta/meta.dart';
import 'package:openid_client/openid_client.dart';

class UserCredentials {
  Credential credential;
  List<String> roles;
  Exception exception;

  UserCredentials.withCredentials({@required this.credential, this.roles});

  UserCredentials.withException({@required this.exception});
}

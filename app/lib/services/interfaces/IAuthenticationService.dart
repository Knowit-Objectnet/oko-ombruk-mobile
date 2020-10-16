import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/UserModel.dart';
import 'package:openid_client/openid_client.dart';

abstract class IAuthenticationService {
  Future<UserModel> loadFromStorage();

  Future<void> deleteCredentials();

  Future<CustomResponse> requestLogOut(
    String accessToken,
    String refreshToken,
    String clientID,
  );

  Future<CustomResponse> requestLogOut1();

  UserModel get userModel;

  Future<UserModel> saveCredentials({
    Credential credential,
    List<String> roles,
    int groupID,
  });

  Future<CustomResponse<UserModel>> requestRefreshToken({
    String clientId,
    String refreshToken,
  });
}

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/UserInfo.dart';
import 'package:ombruk/models/UserModel.dart';
import 'package:ombruk/services/interfaces/ISecureStorageService.dart';
import 'package:openid_client/openid_client.dart' as OID;

abstract class IAuthenticationService {
  Future<UserModel> loadFromStorage();

  Future<UserInfo> getUserInfo();

  Future<void> deleteCredentials();

  Future<CustomResponse> requestLogOut(
    String accessToken,
    String refreshToken,
    String clientID,
  );

  Future<CustomResponse> requestLogOut1();

  UserModel get userModel;

  Future<UserModel> saveCredentials({
    OID.Credential credential,
    List<String> roles,
    int groupID,
  });

  Future<CustomResponse<UserModel>> requestRefreshToken();

  void updateDependencies(ISecureStorageService secureStorageService);
}

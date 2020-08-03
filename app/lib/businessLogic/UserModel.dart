class UserModel {
  String accessToken;
  String refreshToken;
  String clientId;
  List<String> roles;

  UserModel(this.accessToken, this.refreshToken, this.clientId, this.roles);
}

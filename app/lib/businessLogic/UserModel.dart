class UserModel {
  String accessToken;
  String refreshToken;
  String clientId;
  List<String> roles;

  UserModel(this.accessToken, this.refreshToken, this.clientId, this.roles);

  Map<String, dynamic> _toJson() => {
        'accessToken': accessToken.substring(0, 10),
        'refreshToken': refreshToken.substring(0, 10),
        'clientId': clientId,
        'roles': roles.toString(),
      };

  @override
  String toString() {
    return _toJson().toString();
  }
}

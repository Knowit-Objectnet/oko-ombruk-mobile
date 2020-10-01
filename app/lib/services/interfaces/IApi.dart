import 'package:ombruk/models/CustomResponse.dart';

abstract class IApi {
  Future<CustomResponse<String>> getRequest(
    String path,
    Map<String, String> parameters,
  );

  Future<CustomResponse<String>> postRequest(
    String path,
    String body,
  );

  Future<CustomResponse<String>> deleteRequest(
    String path,
    Map<String, String> parameters,
  );

  Future<CustomResponse<String>> patchRequest(
    String path,
    String body,
  );
}

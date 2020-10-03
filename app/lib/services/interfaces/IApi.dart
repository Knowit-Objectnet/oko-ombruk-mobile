import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/IForm.dart';

abstract class IApi {
  Future<CustomResponse<String>> getRequest(
    String path,
    IForm form,
  );

  Future<CustomResponse<String>> postRequest(
    String path,
    IForm form,
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

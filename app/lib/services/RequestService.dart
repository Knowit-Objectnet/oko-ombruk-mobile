import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/services/forms/request/class%20RequestGetForm.dart';
import 'package:ombruk/services/forms/request/class%20RequestDeleteForm.dart';
import 'package:ombruk/services/forms/request/RequestPostForm.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/interfaces/IRequestService.dart';
import 'package:ombruk/services/mixins/ParseResponse.dart';

class RequestService with ParseResponse implements IRequestService {
  ICacheService _cacheService;
  RequestService(this._cacheService);
  @override
  Future<CustomResponse> deleteRequest(RequestDeleteForm form) async {
    return await _cacheService.deleteRequest(ApiEndpoint.requests, form);
  }

  @override
  Future<CustomResponse<List<Request>>> fetchRequests(
    RequestGetForm form, {
    Function(CustomResponse<List<Request>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      path: ApiEndpoint.requests,
      form: form,
      parser: _parseResponse,
      newDataCallback: newDataCallback,
    );
    return response.success ? _parseResponse(response) : response;
  }

  CustomResponse<List<Request>> _parseResponse(CustomResponse response) {
    return parseList<Request>(response, (req) => Request.fromJson(req));
  }

  @override
  Future<CustomResponse> postRequest(RequestPostForm form) async {
    CustomResponse response =
        await _cacheService.postRequest(ApiEndpoint.requests, form);
    return response.success
        ? parseObject<Request>(response, (req) => Request.fromJson(req))
        : response;
  }

  @override
  void updateDependencies(ICacheService cacheService) {
    _cacheService = cacheService;
  }
}

import 'dart:convert';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/services/forms/request/class%20RequestGetForm.dart';
import 'package:ombruk/services/forms/request/class%20RequestDeleteForm.dart';
import 'package:ombruk/services/forms/request/RequestPostForm.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IRequestService.dart';

class RequestService implements IRequestService {
  final IApi _api;
  RequestService(this._api);
  @override
  Future<CustomResponse> deleteRequest(RequestDeleteForm form) async {
    return await _api.deleteRequest(ApiEndpoint.requests, form);
  }

  @override
  Future<CustomResponse<List<Request>>> fetchRequests(
    RequestGetForm form,
  ) async {
    CustomResponse response =
        await _api.getRequest(path: ApiEndpoint.requests, form: form);
    if (!response.success) return response;

    try {
      List<Request> requests = List<dynamic>.from(jsonDecode(response.data))
          .map((request) => Request.fromJson(request))
          .toList();
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: requests,
      );
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: e.toString(),
      );
    }
  }

  @override
  Future<CustomResponse> postRequest(RequestPostForm form) async {
    CustomResponse response =
        await _api.postRequest(ApiEndpoint.requests, form);
    if (!response.success) return response;

    try {
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: Request.fromJson(jsonDecode(response.data)),
      );
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: e.toString(),
      );
    }
  }
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';

abstract class ICacheService<T> {
  Future<CustomResponse<String>> getRequest({
    @required String path,
    @required IForm form,
    @required Function(CustomResponse) parser,
    dynamic newDataCallback,
  });
  void updateDependencies(IApi api);
  Future<void> invalidateEndpoint(String endpoint);
  void removeCallback(Function function, String path);
  Future<CustomResponse> patchRequest(String path, IForm form);
  Future<CustomResponse> deleteRequest(String path, IForm form);
  Future<CustomResponse> postRequest(String path, IForm form);
}

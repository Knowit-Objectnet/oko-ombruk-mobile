import 'dart:async';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';

class CacheService implements ICacheService {
  Map<String, String> _cache = Map();

  IApi _api;
  CacheService(this._api);
  @override
  void dispose() {
    // _cache.values.forEach((object) => object.streamController.close());
  }

  void updateDependencies(IApi api) {
    _api = api;
  }

  Future<CustomResponse> getRequest(
    IForm form,
    String path, {
    Function(CustomResponse) newDataCallback,
  }) async {
    String url = Uri.https(ApiEndpoint.baseUrlStripped,
            '${ApiEndpoint.requiredPath}/$path', form.encode())
        .toString();
    print(_cache.keys);
    if (_cache.containsKey(url)) {
      print("cache contains key");
      if (newDataCallback != null) _fetchNewData(form, path, newDataCallback);
      return CustomResponse(success: true, statusCode: 200, data: _cache[url]);
    } else {
      print("cache does not contain key");
      CustomResponse response = await _api.getRequest(path, form);
      if (response.success) {
        _cache[url] = response.data;
      }
      return response;
    }
  }

  void _fetchNewData(
      IForm form, String path, Function(CustomResponse) newDataCallback) async {
    CustomResponse response = await _api.getRequest(path, form);
    if (response.success) {
      String url = Uri.https(ApiEndpoint.baseUrlStripped,
              '${ApiEndpoint.requiredPath}/$path', form.encode())
          .toString();
      print("equals: ${response.data == _cache[url]}");
      if (response.data != _cache[url]) {
        _cache[url] = response.data;
        print("should update");
        newDataCallback(response);
      }
    }
  }
}

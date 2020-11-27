import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CacheObject.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/mixins/UseCache.dart';

class CacheService<T> with UseCache implements ICacheService {
  Map<String, Map<String, CacheObject>> _urlCache = Map();

  IApi _api;
  CacheService(this._api);

  @override
  void updateDependencies(IApi api) {
    _api = api;
  }

  @override
  Future<CustomResponse<String>> getRequest({
    @required IForm form,
    @required String path,
    @required Function(CustomResponse) parser,
    dynamic newDataCallback,
  }) async {
    String url = Uri.https(ApiEndpoint.baseUrlStripped,
            '${ApiEndpoint.requiredPath}/$path', form.encode())
        .toString();
    if (!_urlCache.containsKey(path)) {
      _urlCache.putIfAbsent(path, () => Map<String, CacheObject>());
    }

    // print(_urlCache);

    CacheObject cacheObject = _urlCache[path][url];

    if (cacheObject != null) {
      // print("cache contains key");
      // print(cacheObject?.callbacks?.first.runtimeType);
      // print(cacheObject.callbacks[0] == cacheObject.callbacks[1]);
      // cacheObject.callbacks.forEach((element) {
      //   print(element.runtimeType);
      // });
      // newDataCallback(CustomResponse(
      // success: true, statusCode: 200, data: cacheObject.json));
      // print(cacheObject.callbacks.contains(newDataCallback));
      if (newDataCallback != null) {
        cacheObject.callbacks.add(newDataCallback);
      }
      print("Callback length ${cacheObject.callbacks.length} $url");
      _handleFetchNewData(Uri.parse(url), cacheObject);
      return CustomResponse<String>(
        success: true,
        statusCode: 200,
        data: cacheObject.json,
      );
    } else {
      // print("Cache does not contain key. Adding");
      CustomResponse response = await _api.getRequest(path: path, form: form);
      if (!response.success) {
        return response;
      }
      CacheObject obj = CacheObject(response.data, parser: parser);
      if (newDataCallback != null) {
        obj.callbacks.add(newDataCallback);
      }
      _urlCache[path].putIfAbsent(url, () => obj);
      return response;
    }
  }

  Future<void> _handleFetchNewData(Uri uri, CacheObject cacheObject) async {
    CustomResponse response = await _api.getRequest(uri: uri);
    if (response.success && response.data != cacheObject.json) {
      cacheObject.json = response.data;
      cacheObject.invalidated = false;
      cacheObject.callbacks
          .forEach((callback) => callback(cacheObject.parser(response)));
    }
  }

  @override
  Future<void> invalidateEndpoint(String endpoint) async =>
      await _invalidateAndFetch(endpoint);

  Future<void> _invalidateAndFetch(String path) async {
    if (_urlCache[path] == null) {
      return;
    }
    print("Invalidating the following caches:");
    _urlCache[path].keys.forEach((element) {
      print(element);
    });
    if (_urlCache[path] == null) return;
    await Future.forEach<MapEntry<String, CacheObject>>(
      _urlCache[path].entries,
      (entry) => _handleFetchNewData(Uri.parse(entry.key), entry.value),
    );
  }

  Future<CustomResponse> _genericRequest(
      Function(String, IForm) request, IForm form, String path) async {
    CustomResponse response = await request(path, form);
    if (!response.success) {
      return response;
    }
    _invalidateAndFetch(path);
    return response;
  }

  @override
  void removeCallback(Function function, String path) {
    if (_urlCache.containsKey(path)) {
      _urlCache[path].values.forEach((cacheObject) {
        if (cacheObject.callbacks.contains(function)) {
          print("Removed function");
          cacheObject.callbacks.remove(function);
        }
      });
    }
  }

  @override
  Future<CustomResponse> patchRequest(String path, IForm form) =>
      _genericRequest(_api.patchRequest, form, path);

  @override
  Future<CustomResponse> deleteRequest(String path, IForm form) =>
      _genericRequest(_api.deleteRequest, form, path);

  @override
  Future<CustomResponse> postRequest(String path, IForm form) =>
      _genericRequest(_api.postRequest, form, path);
}
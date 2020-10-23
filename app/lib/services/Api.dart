import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/ISecureStorageService.dart';

class Api implements IApi {
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final ISecureStorageService _secureStorageService;
  final IAuthenticationService _authenticationService;
  Api(this._secureStorageService, this._authenticationService);

  void _updateTokenInHeader() async {
    final String token =
        'Bearer ' + _authenticationService.userModel.accessToken;
    if (_headers.containsKey('Authorization')) {
      _headers.update('Authorization', (value) => token);
    } else {
      _headers.putIfAbsent('Authorization', () => token);
    }
  }

  Future<CustomResponse<String>> getRequest(String path, IForm form) async {
    Uri uri = Uri.https(ApiEndpoint.baseUrlStripped,
        '${ApiEndpoint.requiredPath}/$path', form.encode());
    final Response response = await get(uri, headers: _headers);

    // This should probably be done differently, but I'm improving this incrementally.
    return CustomResponse(
      success: response.statusCode == HttpStatus.ok,
      statusCode: response.statusCode,
      data: response.statusCode == HttpStatus.ok ? response.body : null,
      message: response.statusCode == HttpStatus.ok ? null : response.body,
    );
  }

  Future<CustomResponse<String>> postRequest(String path, IForm form) async {
    Uri uri = Uri.https(
        ApiEndpoint.baseUrlStripped, '${ApiEndpoint.requiredPath}/$path');

    return await _authorizedRequest(
        post, [uri], {#headers: _headers, #body: jsonEncode(form.encode())});
  }

  Future<CustomResponse<String>> deleteRequest(
    String path,
    IForm form,
  ) async {
    Uri uri = Uri.https(ApiEndpoint.baseUrlStripped,
        '${ApiEndpoint.requiredPath}/$path', form.encode());

    return await _authorizedRequest(delete, [uri], {#headers: _headers});
  }

  Future<CustomResponse<String>> patchRequest(String path, IForm form) async {
    Uri uri = Uri.https(
        ApiEndpoint.baseUrlStripped, '${ApiEndpoint.requiredPath}/$path');

    return await _authorizedRequest(
        patch, [uri], {#headers: _headers, #body: jsonEncode(form.encode())});
  }

  Future<CustomResponse<String>> _authorizedRequest(
      Function request, List<dynamic> positionalArgs,
      [Map<Symbol, dynamic> optionalArguments]) async {
    _updateTokenInHeader();
    Response response =
        await Function.apply(request, positionalArgs, optionalArguments);

    if (response.statusCode == HttpStatus.unauthorized) {
      final bool gotNewTokens =
          await _authenticationService.requestRefreshToken() != null;
      if (gotNewTokens) {
        _updateTokenInHeader();
        print(_headers);
        response =
            await Function.apply(request, positionalArgs, optionalArguments);
      } else {
        // Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
      }
    }

    return CustomResponse(
      success: response.statusCode == HttpStatus.ok,
      statusCode: response.statusCode,
      data: response.statusCode == HttpStatus.ok ? response.body : null,
      message: response.statusCode == HttpStatus.ok ? null : response.body,
    );
  }
}

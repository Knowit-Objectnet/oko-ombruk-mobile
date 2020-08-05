import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/businessLogic/Partner.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/serviceLocator.dart';
import 'package:ombruk/globals.dart' as globals;

class PartnerService {
  final UserViewModel _userViewModel = serviceLocator<UserViewModel>();

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  void _updateTokenInHeader() {
    final String token = 'Bearer ' + (_userViewModel?.accessToken ?? '');
    if (_headers.containsKey('Authorization')) {
      _headers.update('Authorization', (value) => token);
    } else {
      _headers.putIfAbsent('Authorization', () => token);
    }
  }

  Future<CustomResponse<List<Partner>>> fetchPartners({int id}) async {
    Map<String, String> parameters = {};

    if (id != null) {
      parameters.putIfAbsent('station-id', () => id.toString());
    }

    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/partners');

    final Response response = await get(uri, headers: _headers);

    if (response.statusCode != 200) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: response.body,
      );
    }

    try {
      List<Partner> partners = [];
      final List<dynamic> parsed = jsonDecode(response.body);
      for (var element in parsed) {
        partners.add(Partner.fromJson(element));
      }
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: partners,
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

  Future<CustomResponse<Partner>> addPartner({
    @required String name,
    String description,
    String phone,
    String email,
  }) async {
    assert(name != null);

    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/partners');

    Map<String, dynamic> bodyParameters = {'name': name};

    if (description != null) {
      bodyParameters.putIfAbsent('description', () => description);
    }
    if (phone != null) {
      bodyParameters.putIfAbsent('phone', () => phone);
    }
    if (email != null) {
      bodyParameters.putIfAbsent('email', () => email);
    }
    String body = jsonEncode(bodyParameters);

    Response response = await post(uri, headers: _headers, body: body);

    // REG authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await post(uri, headers: _headers, body: body);
      } else {
        // Log out due to invalid refesh token
        await _userViewModel.requestLogOut();
      }
    }

    if (response.statusCode == 200) {
      final int id = int.tryParse(response.body);
      if (id == null) {
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: 'Cannot parse ID to integer. ID was $id',
        );
      }
      return CustomResponse<Partner>(
        success: true,
        statusCode: response.statusCode,
        data: Partner(id, name, description, phone, email),
      );
    }

    return CustomResponse(
      success: false,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }

  Future<CustomResponse<Partner>> updatePartner({
    @required int id,
    String name,
    String description,
    String phone,
    String email,
  }) async {
    assert(id != null);

    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/partners');

    Map<String, dynamic> bodyParameters = {'id': id};
    if (name != null) {
      bodyParameters.putIfAbsent('name', () => name);
    }
    if (description != null) {
      bodyParameters.putIfAbsent('description', () => description);
    }
    if (phone != null) {
      bodyParameters.putIfAbsent('phone', () => phone);
    }
    if (email != null) {
      bodyParameters.putIfAbsent('email', () => email);
    }

    String body = jsonEncode(bodyParameters);

    Response response = await post(uri, headers: _headers, body: body);

    // REG authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await post(uri, headers: _headers, body: body);
      } else {
        // Log out due to invalid refesh token
        await _userViewModel.requestLogOut();
      }
    }

    if (response.statusCode == 200) {
      try {
        final dynamic parsed = jsonDecode(response.body);
        Partner partner = Partner.fromJson(parsed);
        return CustomResponse<Partner>(
          success: true,
          statusCode: response.statusCode,
          data: partner,
        );
      } catch (e) {
        return CustomResponse<Partner>(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: e.toString(),
        );
      }
    }

    return CustomResponse(
      success: false,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
  }

  Future<CustomResponse> deletePartner({@required int id}) async {
    assert(id != null);
    _updateTokenInHeader();

    throw UnimplementedError();
  }
}

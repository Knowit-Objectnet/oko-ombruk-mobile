import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ombruk/businessLogic/Partner.dart';
import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/Api.dart';

class PartnerService {
  Api _api = Api();

  Future<CustomResponse<List<Partner>>> fetchPartners({int id}) async {
    Map<String, String> parameters = {};

    if (id != null) {
      parameters.putIfAbsent('stationId', () => id.toString());
    }

    CustomResponse response =
        await _api.getRequest(ApiEndpoint.partners, parameters);

    if (!response.success) {
      return response;
    }

    try {
      List<Partner> partners = List<dynamic>.from(jsonDecode(response.data))
          .map((partner) => Partner.fromJson(partner));
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

    CustomResponse response =
        await _api.postRequest(ApiEndpoint.partners, body);

    if (response.statusCode == 200) {
      try {
        return CustomResponse(
          success: true,
          statusCode: response.statusCode,
          data: Partner.fromJson(jsonDecode(response.data)),
          message: null,
        );
      } catch (error) {
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: 'Cannot parse ID to integer.',
        );
      }
    }

    return response;
  }

  Future<CustomResponse<Partner>> updatePartner({
    @required int id,
    String name,
    String description,
    String phone,
    String email,
  }) async {
    assert(id != null);

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

    //This used to be a post request. Why?
    CustomResponse response =
        await _api.patchRequest(ApiEndpoint.partners, body);

    if (response.statusCode == 200) {
      try {
        return CustomResponse<Partner>(
          success: true,
          statusCode: response.statusCode,
          data: Partner.fromJson(jsonDecode(response.data)),
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

    return response;
  }

  Future<CustomResponse> deletePartner({@required int id}) async {
    assert(id != null);

    throw UnimplementedError();
  }
}

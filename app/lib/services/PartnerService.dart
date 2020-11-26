import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPatchForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPostForm.dart';
import 'package:ombruk/services/interfaces/CacheService.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';

class PartnerService implements IPartnerService {
  IApi _api;
  CacheService _cacheService;
  PartnerService(this._api, this._cacheService);

  void updateDependencies(IApi api, CacheService cacheService) {
    this._api = api;
    this._cacheService = cacheService;
  }

  Future<CustomResponse<List<Partner>>> fetchPartners(
    PartnerGetForm form, {
    Function(CustomResponse<List<Partner>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      form,
      ApiEndpoint.partners,
      newDataCallback: newDataCallback,
      parser: _parseResult,
    );
    // CustomResponse response = await _api.getRequest(ApiEndpoint.partners, form);

    if (!response.success) {
      return response;
    }
    return _parseResult(response);
  }

  CustomResponse<List<Partner>> _parseResult(CustomResponse response) {
    try {
      List<Partner> partners = List<dynamic>.from(jsonDecode(response.data))
          .map((partner) => Partner.fromJson(partner))
          .toList();
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

  Future<CustomResponse<Partner>> addPartner(PartnerPostForm form) async {
    CustomResponse response =
        await _cacheService.postRequest(ApiEndpoint.partners, form);

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

  Future<CustomResponse<Partner>> updatePartner(PartnerPatchForm form) async {
    //This used to be a post request. Why?
    CustomResponse response =
        await _cacheService.patchRequest(ApiEndpoint.partners, form);

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

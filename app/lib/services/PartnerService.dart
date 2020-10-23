import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPatchForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPostForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';

class PartnerService implements IPartnerService {
  final IApi _api;
  PartnerService(this._api);

  Future<CustomResponse<List<Partner>>> fetchPartners(
    PartnerGetForm form,
  ) async {
    CustomResponse response = await _api.getRequest(ApiEndpoint.partners, form);

    if (!response.success) {
      return response;
    }

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
        await _api.postRequest(ApiEndpoint.partners, form);

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
        await _api.patchRequest(ApiEndpoint.partners, form);

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

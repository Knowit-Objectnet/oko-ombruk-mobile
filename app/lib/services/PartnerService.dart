import 'package:flutter/material.dart';

import 'package:ombruk/const/ApiEndpoint.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPatchForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPostForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';
import 'package:ombruk/services/mixins/ParseResponse.dart';

class PartnerService with ParseResponse implements IPartnerService {
  ICacheService _cacheService;
  PartnerService(this._cacheService);

  @override
  void updateDependencies(ICacheService cacheService) {
    this._cacheService = cacheService;
  }

  @override
  Future<CustomResponse<List<Partner>>> fetchPartners(
    PartnerGetForm form, {
    Function(CustomResponse<List<Partner>>) newDataCallback,
  }) async {
    CustomResponse response = await _cacheService.getRequest(
      path: ApiEndpoint.partners,
      form: form,
      newDataCallback: newDataCallback,
      parser: _parseResult,
    );

    if (!response.success) {
      return response;
    }
    return _parseResult(response);
  }

  CustomResponse<List<Partner>> _parseResult(CustomResponse response) {
    return parseList<Partner>(response, (partner) => Partner.fromJson(partner));
  }

  @override
  Future<CustomResponse<Partner>> addPartner(PartnerPostForm form) async {
    CustomResponse response =
        await _cacheService.postRequest(ApiEndpoint.partners, form);
    if (!response.success) {
      return response;
    }
    return parseObject<Partner>(
      response,
      (partner) => Partner.fromJson(partner),
    );
  }

  @override
  Future<CustomResponse<Partner>> updatePartner(PartnerPatchForm form) async {
    CustomResponse response =
        await _cacheService.patchRequest(ApiEndpoint.partners, form);
    if (!response.success) {
      return response;
    }
    return parseObject<Partner>(
      response,
      (partner) => Partner.fromJson(partner),
    );
  }

  @override
  Future<CustomResponse> deletePartner({@required int id}) async {
    assert(id != null);

    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPatchForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPostForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';

abstract class IPartnerService {
  Future<CustomResponse<List<Partner>>> fetchPartners(
    PartnerGetForm form, {
    Function(CustomResponse<List<Partner>>) newDataCallback,
  });

  Future<CustomResponse<Partner>> addPartner(PartnerPostForm form);

  Future<CustomResponse<Partner>> updatePartner(PartnerPatchForm form);

  Future<CustomResponse> deletePartner({@required int id});
  void updateDependencies(ICacheService cacheService);
}

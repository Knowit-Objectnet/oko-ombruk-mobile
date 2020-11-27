import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/Partner/PartnerGetForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPatchForm.dart';
import 'package:ombruk/services/forms/Partner/PartnerPostForm.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class PartnerViewModel extends BaseViewModel {
  final IPartnerService _partnerService;

  List<Partner> _partners = [];

  PartnerViewModel(this._partnerService) {
    fetchPartners();
  }

  @override
  Future<void> init() async {
    fetchPartners();
    setState(ViewState.Idle);
  }

  List<Partner> get partners => _partners;

  Future<bool> fetchPartners({int id}) async {
    //Partners were fetched based on station id before, not sure why..
    PartnerGetForm form = PartnerGetForm(stationId: id);
    final CustomResponse<List<Partner>> response =
        await _partnerService.fetchPartners(form);

    if (response.success) {
      _partners = response.data;
      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> addPartner({
    @required String name,
    String description,
    String phone,
    String email,
  }) async {
    PartnerPostForm form = PartnerPostForm(name, description, phone, email);
    final CustomResponse<Partner> response =
        await _partnerService.addPartner(form);

    if (response.success) {
      _partners.add(response.data);
      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> updatePartner({
    @required int id,
    String name,
    String description,
    String phone,
    String email,
  }) async {
    PartnerPatchForm form = PartnerPatchForm(
      partnerId: id,
      name: name,
      description: description,
      phone: phone,
      email: email,
    );
    final CustomResponse<Partner> response =
        await _partnerService.updatePartner(form);
    if (response.success) {
      final int index = partners.indexWhere((element) => element.id == id);
      _partners[index] = response.data;
      notifyListeners();
      return true;
    } else {
      print(response);
      return false;
    }
  }

  Future<bool> deletePartner({@required int id}) {
    assert(id != null);
    throw UnimplementedError();
  }
}

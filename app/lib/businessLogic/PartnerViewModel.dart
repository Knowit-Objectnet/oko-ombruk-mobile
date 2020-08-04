import 'package:flutter/material.dart';
import 'package:ombruk/businessLogic/Partner.dart';
import 'package:ombruk/services/PartnerService.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/serviceLocator.dart';

class PartnerViewModel extends ChangeNotifier {
  final PartnerService _partnerService = serviceLocator<PartnerService>();

  List<Partner> _partners = [];

  PartnerViewModel() {
    fetchPartners();
  }

  List<Partner> get partners => _partners;

  Future<bool> fetchPartners({int id}) async {
    final CustomResponse<List<Partner>> response =
        await _partnerService.fetchPartners(id: id);

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
    final CustomResponse<Partner> response = await _partnerService.addPartner(
      name: name,
      description: description,
      phone: phone,
      email: email,
    );

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
    final CustomResponse<Partner> response =
        await _partnerService.updatePartner(
      id: id,
      name: name,
      description: description,
      phone: phone,
      email: email,
    );
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

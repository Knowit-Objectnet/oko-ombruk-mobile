import 'package:flutter/material.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class NewPartnerViewModel extends BaseViewModel {
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController _partnerNameController = TextEditingController();
  TextEditingController get partnerNameController => _partnerNameController;

  void submitForm() async {}

  String validatePartnerName(String value) {}

  @override
  void dispose() {
    _partnerNameController.dispose();
    super.dispose();
  }
}

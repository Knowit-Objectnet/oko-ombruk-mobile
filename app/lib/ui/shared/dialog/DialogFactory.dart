import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/pickup/dialog/PickupDialogPartners.dart';
import 'package:ombruk/ui/shared/dialog/LoadingDialog.dart';

enum DialogType { Loading, WeightReporting, PickupDialogPartners }

abstract class DialogFactory {
  static Widget create(DialogType type) {
    switch (type) {
      case DialogType.Loading:
        return LoadingDialog();
      case DialogType.PickupDialogPartners:
        return PickupDialogPartners();
      default:
        return Scaffold(
          appBar: AppBar(
            title: Text("Error"),
          ),
          body: Text("You shouldn't be here"),
        );
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:ombruk/const/ApiParameters.dart';
import 'package:ombruk/services/forms/IForm.dart';

class ReportPatchForm implements IForm {
  final int reportId;
  final int weight;
  ReportPatchForm({@required this.reportId, @required this.weight}) {
    if (!validate()) {
      throw Exception("ReportPatchForm could not be validated");
    }
  }
  @override
  Map<String, dynamic> encode() => {
        ApiParameters.reportId: reportId,
        ApiParameters.reportWeight: weight,
      };

  @override
  bool validate() {
    if (reportId == null || reportId < 1) {
      return false;
    }
    //bomturer?
    if (weight == null || weight < 0) {
      return false;
    }
    return true;
  }
}

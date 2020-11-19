import 'package:flutter/foundation.dart';
import 'package:ombruk/services/forms/IForm.dart';
import 'package:ombruk/utils/DateUtils.dart';

class PickupUpdateForm implements IForm {
  int id;
  DateTime startDateTime;
  DateTime endDateTime;
  String description;
  int chosenPartnerId;
  PickupUpdateForm(
      {@required this.id,
      this.startDateTime,
      this.endDateTime,
      this.description,
      this.chosenPartnerId});

  @override
  Map<String, dynamic> encode() => {
        'id': id.toString(),
        if (startDateTime != null)
          'startDateTime': DateUtils.getDateString(startDateTime),
        if (endDateTime != null)
          'endDateTime': DateUtils.getDateString(endDateTime),
        if (description != null) 'description': description,
        if (chosenPartnerId != null)
          'chosenPartnerId': chosenPartnerId.toString(),
      };

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}

import 'package:ombruk/services/forms/IForm.dart';

class RequestGetForm extends IForm {
  int pickupId;
  int partnerId;
  RequestGetForm({this.pickupId, this.partnerId});
  @override
  Map<String, String> encode() => {
        if (pickupId != null) 'pickupId': pickupId.toString(),
        if (partnerId != null) 'partnerId': partnerId.toString(),
      };

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}

import 'package:ombruk/services/forms/IForm.dart';

class RequestPostForm implements IForm {
  int pickupId;
  int partnerId;
  RequestPostForm(this.pickupId, this.partnerId) {
    assert(pickupId != null);
    assert(partnerId != null);
  }
  @override
  Map<String, String> encode() => {
        'pickupId': pickupId.toString(),
        'partnerId': partnerId.toString(),
      };

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
  }
}

import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';

abstract class IPickupService {
  Future<CustomResponse> addPickup(PickupPostForm form);

}
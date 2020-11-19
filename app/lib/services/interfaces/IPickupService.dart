import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/services/forms/pickup/PickupDeleteForm.dart';
import 'package:ombruk/services/forms/pickup/PickupGetForm.dart';
import 'package:ombruk/services/forms/pickup/PickupPostForm.dart';
import 'package:ombruk/services/forms/pickup/PickupUpdateForm.dart';

abstract class IPickupService {
  Future<CustomResponse> addPickup(PickupPostForm form);
  Future<CustomResponse<List<Pickup>>> fetchPickups(PickupGetForm form);
  Future<CustomResponse> deletePickup(PickupDeleteForm form);
  Future<CustomResponse> updatePickup(PickupUpdateForm form);
}

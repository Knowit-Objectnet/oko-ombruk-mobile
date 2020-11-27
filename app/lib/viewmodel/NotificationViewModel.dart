import 'package:ombruk/globals.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/models/UserInfo.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/forms/pickup/PickupGetForm.dart';
import 'package:ombruk/services/forms/pickup/PickupUpdateForm.dart';
import 'package:ombruk/services/forms/request/RequestPostForm.dart';
import 'package:ombruk/services/forms/request/class%20RequestDeleteForm.dart';
import 'package:ombruk/services/forms/request/class%20RequestGetForm.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';
import 'package:ombruk/services/interfaces/IRequestService.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class NotificationViewModel extends BaseViewModel {
  final IPickupService _pickupService;
  final IRequestService _requestService;
  final SnackbarService _snackbarService;
  final IAuthenticationService _authenticationService;
  List<Pickup> _finishedPickups = List();
  List<Pickup> get finishedPickups => _finishedPickups;
  List<Pickup> _pickups = List();
  List<Pickup> get pickups => _pickups;
  UserInfo _userInfo;
  KeycloakRoles get role => _userInfo.role;

  NotificationViewModel(
    this._authenticationService,
    this._pickupService,
    this._snackbarService,
    this._requestService,
  ) : super(state: ViewState.Busy);

  @override
  Future<void> init() => _authenticationService
      .getUserInfo()
      .then((info) => _userInfo = info)
      .then((value) => getPickups())
      .whenComplete(() => setState(ViewState.Idle));

  Future<CustomResponse<List<Request>>> _getRequests(
      {bool notify = false}) async {
    RequestGetForm form = RequestGetForm();
    CustomResponse<List<Request>> response =
        await _requestService.fetchRequests(form);
    if (!response.success) {
      print(response.message);
      _snackbarService.showSimpleSnackbar("Kunne ikke hente forespørsler");
    }
    return response;
  }

  Future<void> addRequest(Pickup pickup) async {
    CustomResponse response = await _requestService
        .postRequest(RequestPostForm(pickup.id, _userInfo.groupId));
    if (!response.success) {
      _snackbarService.showSimpleSnackbar("Kunne ikke legge til forespørsel");
      return;
    }
    pickup.requests.add(response.data);
    notifyListeners();
  }

  Future<void> deleteRequest(Pickup pickup, {int partnerId}) async {
    if (partnerId == null) {
      partnerId = _userInfo.groupId;
    }
    CustomResponse response = await _requestService.deleteRequest(
      RequestDeleteForm(
        pickup.id,
        partnerId,
      ),
    );

    if (!response.success) {
      _snackbarService.showSimpleSnackbar("Klarte ikke slette forespørsel");
      return;
    }
    pickup.requests.removeWhere((req) => req.partner.id == partnerId);
    notifyListeners();
  }

  Future<void> getPickups({bool notify = false}) async {
    PickupGetForm form;
    if (_userInfo.role == KeycloakRoles.reuse_station) {
      form = PickupGetForm(stationId: _userInfo.groupId);
    } else {
      form = PickupGetForm();
    }
    CustomResponse<List<Pickup>> response =
        await _pickupService.fetchPickups(form);

    if (!response.success) {
      print(response.message);
      return _snackbarService
          .showSimpleSnackbar("Kunne ikke hente forespørsler");
    }
    CustomResponse<List<Request>> requests = await _getRequests();
    if (!requests.success) return;

    Map<int, Pickup> tmpFinishedPickups = Map.fromIterable(
      response.data.where((pickup) => pickup.chosenPartner != null),
      key: (pickup) => pickup.id,
      value: (pickup) => pickup,
    );

    response.data.removeWhere((pickup) => pickup.chosenPartner != null);

    Map<int, Pickup> tmpPickups = Map.fromIterable(
      response.data,
      key: (pickup) => pickup.id,
      value: (pickup) => pickup,
    );

    // Use null safety to filter out requests that don't have their corresponding pickup.
    requests.data.forEach((req) {
      if (tmpPickups.containsKey(req.pickup.id)) {
        tmpPickups[req.pickup.id]?.requests?.add(req);
      } else if (tmpFinishedPickups.containsKey(req.pickup.id)) {
        tmpFinishedPickups[req.pickup.id].requests.add(req);
      }
    });
    _pickups = tmpPickups.values.toList();
    _finishedPickups = tmpFinishedPickups.values.toList();
    if (notify) notifyListeners();
  }

  Future<void> approveRequest(Request request) async {
    CustomResponse response = await _pickupService.updatePickup(
      PickupUpdateForm(
        id: request.pickup.id,
        chosenPartnerId: request.partner.id,
      ),
    );

    if (!response.success) {
      _snackbarService.showSimpleSnackbar("Klarte ikke sende forespørsel");
      return;
    }
    getPickups(notify: true);
  }

  bool hasApplied(Pickup pickup) =>
      pickup.requests.isNotEmpty &&
      pickup.requests.any((req) => req.partner.id == _userInfo.groupId);

  bool isRejected(Pickup pickup) =>
      pickup.chosenPartner != null &&
      pickup.chosenPartner.id != _userInfo.groupId;

  bool belongsToPartner(Pickup pickup) =>
      pickup.chosenPartner != null &&
      pickup.chosenPartner.id == _userInfo.groupId;
}

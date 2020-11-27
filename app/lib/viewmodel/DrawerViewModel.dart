import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/dialog/DialogFactory.dart';
import 'package:ombruk/ui/shared/model/DrawerItem.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class DrawerViewModel extends BaseViewModel {
  KeycloakRoles _role;
  final INavigatorService _navigatorService;
  final IAuthenticationService _authenticationService;
  final DialogService _dialogService;
  List<DrawerItem> get drawerItems => [
        DrawerItem(
          icon: CustomIcons.partners,
          title: 'Sam. partnere',
          onTap: () => null,
          isSelected: false,
        ),
        DrawerItem(
          icon: CustomIcons.map,
          title: 'Stasjonene',
          onTap: () => null,
          isSelected: false,
        ),
        if (_role == KeycloakRoles.reuse_station)
          DrawerItem(
            icon: CustomIcons.add,
            title: "Utlys ekstrauttak",
            onTap: () =>
                _navigatorService.navigateAndReplace(Routes.AddExtraPickupView),
            isSelected: false,
          ),
        if (_role == KeycloakRoles.partner)
          DrawerItem(
            icon: CustomIcons.add,
            title: "Søk ekstrauttak",
            onTap: () {
              _navigatorService.goBack();
              _dialogService.openDialog(DialogType.PickupDialogPartners);
            },
            isSelected: false,
          ),
        if (_role == KeycloakRoles.reg_employee)
          DrawerItem(
            icon: CustomIcons.add,
            title: 'Opprett hendelse',
            onTap: () => _navigatorService
                .navigateAndReplace(Routes.CreateOccurenceView),
            isSelected: false,
          ),
        if (_role == KeycloakRoles.reuse_station)
          DrawerItem(
            icon: CustomIcons.weight,
            title: "Vektuttak",
            onTap: () =>
                _navigatorService.navigateAndReplace(Routes.WeightReportView),
            isSelected: false,
          ),
        DrawerItem(
          icon: CustomIcons.addDiscrepancy,
          title: 'Send beskjed',
          onTap: () => _navigatorService.navigateAndReplace(Routes.MessageView),
          isSelected: false,
        ),
        DrawerItem(
            icon: CustomIcons.myPage,
            title: 'Min side',
            onTap: () =>
                _navigatorService.navigateAndReplace(Routes.MinSideView),
            isSelected: false //_selectedIndex == 4,
            ),
      ];

  @override
  Future<void> init() async {
    _role =
        await _authenticationService.getUserInfo().then((value) => value.role);
    setState(ViewState.Idle);
  }

  DrawerViewModel(
    this._navigatorService,
    this._authenticationService,
    this._dialogService,
  ) : super(state: ViewState.Busy);
}

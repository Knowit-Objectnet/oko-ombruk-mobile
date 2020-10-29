import 'package:flutter/material.dart';
import 'package:ombruk/const/TabItems.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/shared/model/AppView.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class TabViewModel extends BaseViewModel {
  INavigatorService _navigatorService;
  IAuthenticationService _authenticationService;
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int _index;
  KeycloakRoles _role;
  TabViewModel(this._navigatorService, this._authenticationService) {
    _scaffoldKey = _navigatorService.scaffoldKey;
  }

  void init() async {
    setState(ViewState.Busy);
    if (_authenticationService.userModel == null) {
      await _authenticationService.loadFromStorage();
    }
    this._role = getRole(_authenticationService.userModel.roles
        .firstWhere((role) => getRole(role) != null, orElse: () => null));
    _index = tabItems[_role].defaultIndex;
    _navigatorService
        .onTabChanged(tabItems[_role].navItems[_index].navigatorKey);
    setState(ViewState.Idle);
  }

  final Map<KeycloakRoles, AppView> tabItems = TabItems.tabItems;
  AppView get view => tabItems[_role];
  int get index => _index;

  void onTabChanged(int index) {
    _navigatorService.onTabChanged(view.navItems[index].navigatorKey);
    _index = index;
    notifyListeners();
  }
}

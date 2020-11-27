import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/shared/const/TabItems.dart';
import 'package:ombruk/ui/shared/model/AppView.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class TabViewModel extends BaseViewModel {
  INavigatorService _navigatorService;
  IAuthenticationService _authenticationService;
  GlobalKey<ScaffoldState> _scaffoldKey;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int _index;
  KeycloakRoles _role;
  TabViewModel(
    this._navigatorService,
    this._authenticationService,
  ) : super(state: ViewState.Busy) {
    _scaffoldKey = _navigatorService.scaffoldKey;
  }

  Future<bool> willPop() async {
    _navigatorService.goBack();
    return false;
  }

  Future<void> init() async {
    _role =
        await _authenticationService.getUserInfo().then((value) => value.role);
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

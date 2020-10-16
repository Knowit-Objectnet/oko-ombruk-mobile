///
/// App
///

import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:ombruk/ui/app/TabView.dart';
import 'package:ombruk/ui/views/BaseWidget.dart';
import 'package:ombruk/viewmodel/AppViewModel.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/ui/SplashScreen.dart';
import 'package:ombruk/ui/login/LoginWebView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: AppViewModel(Provider.of(context)),
      builder: (context, AppViewModel model, child) {
        if (model.state == ViewState.Busy) {
          return SplashScreen();
        }
        if (model.role == null) {
          print("hello login");
          return LoginWebView();
        } else {
          print("hello tab");
          return TabView(model.role);
        }
      },
    );
  }
}

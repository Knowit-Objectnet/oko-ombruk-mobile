///
/// App
///

import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:ombruk/ui/app/SplashScreen.dart';
import 'package:ombruk/ui/app/TabView.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/viewmodel/AppViewModel.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:provider/provider.dart';

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
          return LoginWebView();
        } else {
          return TabView();
        }
      },
    );
  }
}

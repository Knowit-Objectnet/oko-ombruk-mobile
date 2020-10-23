import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/viewmodel/LoginWebViewModel.dart';
import 'package:provider/provider.dart';

class LoginWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: LoginWebViewModel(Provider.of(context), Provider.of(context)),
      builder: (context, LoginWebViewModel model, _) => Scaffold(
        body: Center(
          child: model.state == ViewState.Idle
              ? RaisedButton(
                  child: Text('Logg inn'),
                  onPressed: () {
                    model.login();
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

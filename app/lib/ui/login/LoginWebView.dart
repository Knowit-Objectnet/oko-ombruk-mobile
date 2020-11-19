import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
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
        backgroundColor: CustomColors.osloDarkBlue,
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(76, 202, 84, 0),
                    child: Image(
                      color: CustomColors.osloWhite,
                      image: AssetImage("assets/reir.png"),
                    ),
                  ),
                  FlatButton(
                    child: Text('Logg inn'),
                    color: CustomColors.osloGreen,
                    onPressed: () {
                      model.login();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

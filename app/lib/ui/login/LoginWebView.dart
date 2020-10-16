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
                    // _openKeycloakLogin().then(
                    //   (userCredentials) {
                    //     if (userCredentials.exception != null) {
                    //       uiHelper.hideLoading(context);
                    //       final String exception =
                    //           userCredentials.exception.toString();
                    //       uiHelper.showSnackbar(
                    //           context, exception.substring(11, exception.length));
                    //     } else {
                    //       userViewModel
                    //           .saveCredentials(
                    //             credential: userCredentials.credential,
                    //             roles: userCredentials.roles,
                    //             groupID: userCredentials.groupID,
                    //           )
                    //           .then((value) => uiHelper.hideLoading(context));
                    //     }
                    //   },
                    // );
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
    // return Consumer<UserViewModel>(
    //   builder: (context, userViewModel, child) {
    //     return Scaffold(
    //       body: Builder(
    //         // Builder() so that .showSnackbar has a correct Scaffold
    //         builder: (context) {
    //           return Center(
    //             child: RaisedButton(
    //               child: Text('Logg inn'),
    //               onPressed: () {
    //                 uiHelper.showLoading(context);
    //                 _openKeycloakLogin().then(
    //                   (userCredentials) {
    //                     if (userCredentials.exception != null) {
    //                       uiHelper.hideLoading(context);
    //                       final String exception =
    //                           userCredentials.exception.toString();
    //                       uiHelper.showSnackbar(context,
    //                           exception.substring(11, exception.length));
    //                     } else {
    //                       userViewModel
    //                           .saveCredentials(
    //                             credential: userCredentials.credential,
    //                             roles: userCredentials.roles,
    //                             groupID: userCredentials.groupID,
    //                           )
    //                           .then((value) => uiHelper.hideLoading(context));
    //                     }
    //                   },
    //                 );
    //               },
    //             ),
    //           );
    //         },
    //       ),
    //     );
    //   },
    // );
  }
}

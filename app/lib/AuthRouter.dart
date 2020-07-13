import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart';

import 'package:ombruk/ui/LoadingScreen.dart';
import 'package:ombruk/ui/SplashScreen.dart';
import 'package:ombruk/ui/login/ErrorScreen.dart';
import 'package:ombruk/ui/login/LoginWebView.dart';
import 'package:ombruk/repositories/UserRepository.dart';
import 'package:ombruk/ui/tabs/TabsScreenPartner.dart';
import 'package:ombruk/ui/tabs/TabsScreenReg.dart';
import 'package:ombruk/ui/tabs/TabsScreenStasjon.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/ui.helper.dart';

class AuthRouter extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState newState) {
            if (newState is AuthenticationInProgressLoggingOut) {
              uiHelper.showLoading(context);
            } else {
              uiHelper.hideLoading(context);
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (BuildContext context, AuthenticationState state) {
              switch (state.runtimeType) {
                case AuthenticationInitial:
                  return SplashScreen();
                case AuthenticationInProgressLoggingOut:
                case AuthenticationSuccess:
                  if (userRepository.roles
                      .contains(describeEnum(KeycloakRoles.partner))) {
                    return TabsScreenPartner();
                  }
                  if (userRepository.roles
                      .contains(describeEnum(KeycloakRoles.reg_employee))) {
                    return TabsScreenReg();
                  }
                  if (userRepository.roles
                      .contains(describeEnum(KeycloakRoles.reuse_station))) {
                    return TabsScreenStasjon();
                  }
                  return ErrorScreen(
                      exception: Exception('Du har ikke en rolle'));

                case AuthenticationNoToken:
                  return LoginWebView(userRepository: userRepository);
                case AuthenticationInProgress:
                  return LoadingScreen();
                case AuthenticationError:
                  return ErrorScreen(
                      exception: (state as AuthenticationError).exception);
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

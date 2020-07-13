import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:ombruk/models/UserCredentials.dart';
import 'package:ombruk/repositories/UserRepository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // Takes authEvent as input, return authState as output
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // async* = stream of values

    switch (event.runtimeType) {
      case AuthenticationStarted:
        final bool hasToken = await userRepository.hasCredentials();

        if (hasToken) {
          yield AuthenticationSuccess();
        } else {
          yield AuthenticationNoToken();
        }
        break;
      case AuthenticationLogIn:
        AuthenticationLogIn authIn = event as AuthenticationLogIn;
        if (authIn.userCredentials.exception != null) {
          yield AuthenticationError(
              exception: authIn.userCredentials.exception);
        } else {
          yield AuthenticationInProgress();
          await userRepository.saveCredentials(
              authIn.userCredentials.credential, authIn.userCredentials.roles);
          yield AuthenticationSuccess();
        }
        break;
      case AuthenticationLogOut:
        yield AuthenticationInProgressLoggingOut();
        bool successfulLogout = await userRepository.requestLogOut();
        if (successfulLogout) {
          await userRepository.deleteCredentials();
          yield AuthenticationNoToken();
        } else {
          // TODO: show snackbar or alert message
          yield AuthenticationSuccess();
        }
        break;
    }
  }
}

// States

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  // Equatale: to compare two instances of AuthenticationState. By default, == returns true only if the two objects are the same instance.
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationNoToken extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final Exception exception;

  const AuthenticationError({@required this.exception});

  @override
  List<Object> get props => [exception];
}

class AuthenticationInProgressLoggingOut extends AuthenticationState {}

// Events

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLogIn extends AuthenticationEvent {
  final UserCredentials userCredentials;

  const AuthenticationLogIn({@required this.userCredentials});

  @override
  List<Object> get props => [userCredentials];
}

class AuthenticationLogOut extends AuthenticationEvent {}

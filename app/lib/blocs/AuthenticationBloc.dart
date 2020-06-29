import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:ombruk/resources/UserRepository.dart';
import 'package:openid_client/openid_client.dart';

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
        final bool hasToken = await userRepository.hasToken();

        if (hasToken) {
          yield AuthenticationSuccess();
        } else {
          yield AuthenticationFailure();
        }
        break;
      case AuthenticationLoggedIn:
        yield AuthenticationInProgress();
        await userRepository
            .persistToken((event as AuthenticationLoggedIn).credential);
        yield AuthenticationSuccess();
        break;
      case AuthenticationLoggedOut:
        yield AuthenticationInProgress();
        await userRepository.deleteToken();
        yield AuthenticationFailure();
        break;
    }
  }
}

// States

abstract class AuthenticationState extends Equatable {
  // Equatale: to compare two instances of AuthenticationState. By default, == returns true only if the two objects are the same instance.
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

// Events

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final Credential credential;

  const AuthenticationLoggedIn({@required this.credential});

  @override
  List<Object> get props => [credential];
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

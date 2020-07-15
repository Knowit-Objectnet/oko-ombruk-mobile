import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/models/UserCredentials.dart';
import 'package:ombruk/repositories/UserRepository.dart';

import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:openid_client/openid_client.dart';

class MockUserRepository extends Mock implements UserRepository {}

AuthenticationBloc authenticationBloc;
MockUserRepository mockUserRepository;

void main() {
  setUp(() {
    mockUserRepository = MockUserRepository();
    authenticationBloc = AuthenticationBloc(userRepository: mockUserRepository);
  });

  tearDown(() {
    authenticationBloc?.close();
  });

  test('initial state is correct', () {
    expect(authenticationBloc.initialState, AuthenticationInitial());
  });

  test('close does not emit new states', () {
    expectLater(
      authenticationBloc,
      emitsInOrder([AuthenticationInitial(), emitsDone]),
    );
    authenticationBloc.close();
  });

  group('AppStarted without saved token', () {
    test('emits [initial, noToken] for no saved token', () {
      final expectedResponse = [
        AuthenticationInitial(),
        AuthenticationNoToken()
      ];

      when(mockUserRepository.hasCredentials())
          .thenAnswer((_) => Future.value(false));

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AuthenticationStarted());
    });
  });

  group('App started with saved token', () {
    test('emits [initial, success] for a saved token', () {
      final expectedResponse = [
        AuthenticationInitial(),
        AuthenticationSuccessPartner()
      ];

      when(mockUserRepository.hasCredentials())
          .thenAnswer((_) => Future.value(true));

      when(mockUserRepository.getRole()).thenReturn(KeycloakRoles.partner);

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AuthenticationStarted());
    });
  });

  group('Log in KeyCloak', () {
    test('emits [initial, error] on keycloak exception return', () async {
      final Exception exception = Exception('');

      final expectedResponse = [
        AuthenticationInitial(),
        AuthenticationError(exception: exception)
      ];

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AuthenticationLogIn(
          userCredentials:
              UserCredentials.withException(exception: exception)));

      // when(authenticationBloc.state).thenAnswer((_) => AuthenticationSuccess());
    });

    test('emits [initial, inProgress, success] on keycloak credential return',
        () async {
      final Issuer issuer = await Issuer.discover(Issuer.google);
      final Client client = new Client(issuer, "client_id", "client_secret");
      final Credential credential =
          client.createCredential(accessToken: 'some token');

      when(mockUserRepository.getRole()).thenReturn(KeycloakRoles.partner);

      final expectedResponse = [
        AuthenticationInitial(),
        AuthenticationInProgress(),
        AuthenticationSuccessPartner()
      ];

      expectLater(authenticationBloc, emitsInOrder(expectedResponse));

      authenticationBloc.add(AuthenticationLogIn(
          userCredentials: UserCredentials.withCredentials(
              credential: credential, roles: [])));

      // when(authenticationBloc.state).thenAnswer((_) => AuthenticationSuccess());
    });
  });

  group('Log out', () {
    test('emits [initial, logging out, noToken] on successful logout', () {
      final expectedResponse = [
        AuthenticationInitial(),
        AuthenticationInProgressLoggingOut(
            previousState: AuthenticationSuccessPartner()),
        AuthenticationNoToken()
      ];

      when(mockUserRepository.requestLogOut())
          .thenAnswer((_) => Future.value(true));

      expectLater(authenticationBloc, emitsInOrder(expectedResponse));

      authenticationBloc.add(AuthenticationLogOut());
    });

    test('emits [initial, logging out, still loged in] on failed logout', () {
      final Exception exception = Exception('');

      final expectedResponse = [
        AuthenticationInitial(),
        AuthenticationInProgressLoggingOut(
            previousState: AuthenticationSuccessPartner()),
        AuthenticationError(exception: exception)
      ];

      when(mockUserRepository.requestLogOut())
          .thenAnswer((_) => Future.value(false));

      expectLater(
        authenticationBloc,
        emitsInOrder(expectedResponse),
      );

      authenticationBloc.add(AuthenticationLogOut());
    });
  });
}

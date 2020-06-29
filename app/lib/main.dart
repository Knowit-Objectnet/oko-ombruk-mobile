import 'package:flutter/material.dart';
import 'package:ombruk/LoadingScreen.dart';
import 'package:ombruk/SplashScreen.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/login/ErrorScreen.dart';
// import 'package:ombruk/login/LoginScreen.dart';
import 'package:ombruk/login/LoginWebView.dart';
import 'package:ombruk/resources/UserRepository.dart';
import 'package:ombruk/tabs/TabsScreen.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = BlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(RestartWidget(
    child: BlocProvider<AuthenticationBloc>(
        create: (context) {
          return AuthenticationBloc(userRepository: userRepository)
            ..add(AuthenticationStarted());
        },
        child: MyApp(userRepository: userRepository)),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          switch (state.runtimeType) {
            case AuthenticationInitial:
              return SplashScreen();
            case AuthenticationSuccess:
              return TabsScreen();
            case AuthenticationNoToken:
              return LoginWebView(userRepository: userRepository);
            case AuthenticationInProgress:
              return LoadingScreen();
            case AuthenticationError:
              return ErrorScreen(
                  exception: (state as AuthenticationError).exception);
            default:
              return null;
          }
        },
      ),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => LoadingScreen(),
      //   // '/login': (context) => LoginScreen(),
      //   '/login': (context) => LoginWebView(),
      //   '/home': (context) => TabsScreen()
      // },
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

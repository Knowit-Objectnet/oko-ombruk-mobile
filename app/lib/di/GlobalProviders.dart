import 'package:ombruk/services/Api.dart';
import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentServices,
  ...?dependantServices,
];

List<SingleChildWidget> independentServices = [
  Provider<IAuthenticationService>.value(value: AuthenticationService()),
];

List<SingleChildWidget> dependantServices = [];

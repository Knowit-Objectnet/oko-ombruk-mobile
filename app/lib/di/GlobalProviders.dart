import 'package:ombruk/services/Api.dart';
import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/CalendarService.dart';
import 'package:ombruk/services/DialogService.dart';
import 'package:ombruk/services/NavigatorService.dart';
import 'package:ombruk/services/PartnerService.dart';
import 'package:ombruk/services/PickupService.dart';
import 'package:ombruk/services/RequestService.dart';
import 'package:ombruk/services/SecureStorageService.dart';
import 'package:ombruk/services/SnackbarService.dart';
import 'package:ombruk/services/StationService.dart';
import 'package:ombruk/services/WeightReportService.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/IAuthenticationService.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/services/interfaces/IPartnerService.dart';
import 'package:ombruk/services/interfaces/IPickupService.dart';
import 'package:ombruk/services/interfaces/IRequestService.dart';
import 'package:ombruk/services/interfaces/ISecureStorageService.dart';
import 'package:ombruk/services/interfaces/IStationService.dart';
import 'package:ombruk/services/interfaces/IWeightReportService.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentServices,
  ...?dependantServices,
];

List<SingleChildWidget> independentServices = [
  Provider<ISecureStorageService>.value(value: SecureStorageService()),
  Provider<IAuthenticationService>.value(value: AuthenticationService()),
  Provider<INavigatorService>.value(value: NavigatorService()),
  Provider<DialogService>.value(value: DialogService()),
];

List<SingleChildWidget> dependantServices = [
  ProxyProvider<INavigatorService, SnackbarService>(
      update: (context, navigator, _) => SnackbarService(navigator)),
  ProxyProvider<ISecureStorageService, IAuthenticationService>(
    update: (context, secureStorage, _) =>
        AuthenticationService.test(secureStorage),
  ),
  ProxyProvider2<ISecureStorageService, IAuthenticationService, IApi>(
    update: (context, secureStorage, auth, api) => Api(secureStorage, auth),
  ),
  ProxyProvider<IApi, ICalendarService>(
    update: (context, api, _) => CalendarService(api),
  ),
  ProxyProvider<IApi, IPartnerService>(
    update: (context, api, _) => PartnerService(api),
  ),
  ProxyProvider<IApi, IPickupService>(
    update: (context, api, _) => PickupService(api),
  ),
  ProxyProvider<IApi, IStationService>(
    update: (context, api, _) => StationService(api),
  ),
  ProxyProvider<IApi, IWeightReportService>(
    update: (context, api, _) => WeightReportService(api),
  ),
  ProxyProvider<IApi, IPickupService>(
    update: (context, api, _) => PickupService(api),
  ),
  ProxyProvider<IApi, IRequestService>(
    update: (context, api, _) => RequestService(api),
  ),
];

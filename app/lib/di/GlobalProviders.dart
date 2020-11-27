import 'package:ombruk/services/Api.dart';
import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/CacheService.dart';
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
import 'package:ombruk/services/interfaces/ICacheService.dart';
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
  Provider<ISecureStorageService>(
    create: (context) => SecureStorageService(),
  ),
  Provider<INavigatorService>.value(value: NavigatorService()),
  Provider<DialogService>.value(value: DialogService()),
];

List<SingleChildWidget> dependantServices = [
  ProxyProvider<INavigatorService, SnackbarService>(
      update: (context, navigator, _) => SnackbarService(navigator)),
  ProxyProvider<ISecureStorageService, IAuthenticationService>(
    create: (context) => AuthenticationService(
      Provider.of(context, listen: false),
    ),
    update: (context, secureStorage, prev) =>
        prev..updateDependencies(secureStorage),
  ),
  ProxyProvider2<ISecureStorageService, IAuthenticationService, IApi>(
    update: (context, secureStorage, auth, api) => Api(secureStorage, auth),
  ),
  ProxyProvider<IApi, ICacheService>(
    create: (context) => CacheService(Provider.of(context, listen: false)),
    update: (context, api, service) => service..updateDependencies(api),
  ),
  ProxyProvider<ICacheService, ICalendarService>(
    create: (context) => CalendarService(Provider.of(context, listen: false)),
    update: (context, cache, prev) => prev..updateDependencies(cache),
  ),
  ProxyProvider<ICacheService, IPartnerService>(
    create: (context) => PartnerService(Provider.of(context, listen: false)),
    update: (context, cache, previous) => previous..updateDependencies(cache),
  ),
  ProxyProvider<ICacheService, IStationService>(
    create: (context) => StationService(Provider.of(context, listen: false)),
    update: (context, cache, previous) => previous..updateDependencies(cache),
  ),
  ProxyProvider<ICacheService, IWeightReportService>(
    create: (context) => WeightReportService(
      Provider.of(context, listen: false),
    ),
    update: (context, cache, prev) => prev..updateDependencies(cache),
  ),
  ProxyProvider<ICacheService, IPickupService>(
    create: (context) => PickupService(Provider.of(context, listen: false)),
    update: (context, cache, prev) => prev..updateDependencies(cache),
  ),
  ProxyProvider<ICacheService, IRequestService>(
    create: (context) => RequestService(Provider.of(context, listen: false)),
    update: (context, cache, prev) => prev..updateDependencies(cache),
  ),
];

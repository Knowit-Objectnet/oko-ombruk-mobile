import 'package:get_it/get_it.dart';

import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/CalendarService.dart';
import 'package:ombruk/services/WeightReportService.dart';
import 'package:ombruk/services/PartnerService.dart';
import 'package:ombruk/services/StationService.dart';
import 'package:ombruk/services/PickupService.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/ui/app/AppRouter.dart';
import 'package:ombruk/viewmodel/CalendarViewModel.dart';
import 'package:ombruk/viewmodel/PartnerViewModel.dart';
import 'package:ombruk/viewmodel/PickupViewModel.dart';
import 'package:ombruk/viewmodel/StationViewModel.dart';
import 'package:ombruk/viewmodel/WeightReportViewModel.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // Services
  // serviceLocator.registerLazySingleton<AuthenticationService>(
  //     () => AuthenticationService());
  // serviceLocator.registerLazySingleton<AppRouter>(() => AppRouter());
  // serviceLocator
  //     .registerLazySingleton<CalendarService>(() => CalendarService());
  // serviceLocator
  //     .registerLazySingleton<WeightReportService>(() => WeightReportService());
  // serviceLocator.registerLazySingleton<PartnerService>(() => PartnerService());
  // serviceLocator.registerLazySingleton<StationService>(() => StationService());
  // serviceLocator.registerLazySingleton<PickupService>(() => PickupService());

// ViewModels
  // serviceLocator.registerFactory<UserViewModel>(() => UserViewModel());
  // serviceLocator.registerFactory<CalendarViewModel>(() => CalendarViewModel());
  // serviceLocator
  //     .registerFactory<WeightReportViewModel>(() => WeightReportViewModel());
  // serviceLocator.registerFactory<PartnerViewModel>(() => PartnerViewModel());
  // serviceLocator.registerFactory<StationViewModel>(() => StationViewModel());
  // serviceLocator.registerFactory<PickupViewModel>(() => PickupViewModel());
}

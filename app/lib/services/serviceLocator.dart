import 'package:get_it/get_it.dart';
import 'package:ombruk/businessLogic/CalendarViewModel.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/businessLogic/WeightReportViewModel.dart';
import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/CalendarService.dart';
import 'package:ombruk/services/WeightReportService.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  serviceLocator
      .registerLazySingleton<CalendarService>(() => CalendarService());
  serviceLocator
      .registerLazySingleton<WeightReportService>(() => WeightReportService());

  serviceLocator.registerFactory<UserViewModel>(() => UserViewModel());
  serviceLocator.registerFactory<CalendarViewModel>(() => CalendarViewModel());
  serviceLocator
      .registerFactory<WeightReportViewModel>(() => WeightReportViewModel());
}

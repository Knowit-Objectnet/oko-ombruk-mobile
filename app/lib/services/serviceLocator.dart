import 'package:get_it/get_it.dart';
import 'package:ombruk/businessLogic/CalendarViewModel.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/services/AuthenticationService.dart';
import 'package:ombruk/services/CalendarService.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());
  serviceLocator
      .registerLazySingleton<CalendarService>(() => CalendarService());

  serviceLocator.registerFactory<UserViewModel>(() => UserViewModel());
  serviceLocator.registerFactory<CalendarViewModel>(() => CalendarViewModel());
}

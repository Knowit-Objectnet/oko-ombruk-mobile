import 'package:get_it/get_it.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';
import 'package:ombruk/services/AuthenticationService.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());

  serviceLocator.registerFactory<UserViewModel>(() => UserViewModel());
}

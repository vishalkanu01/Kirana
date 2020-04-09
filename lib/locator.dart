import 'package:kiranaapp/services/authentication_service.dart';
import 'package:kiranaapp/services/firestore_service.dart';
import 'package:get_it/get_it.dart';
import 'package:kiranaapp/services/navigation_service.dart';
import 'package:kiranaapp/services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:newsapp/src/network/api_service.dart';
import 'package:newsapp/src/utils/nav_service.dart';
import 'package:newsapp/src/utils/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

// Function to register our services
void setupServiceLocator() {
  // For pretty printing while debbuging
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));

  // For Saving and Getting items from DB
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());

  // For navigation helper
  sl.registerLazySingleton<NavigatorService>(() => NavigatorService());

  // For api Calls
  sl.registerLazySingleton<ApiService>(() => ApiService());
}

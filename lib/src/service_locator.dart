import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt sl = GetIt.instance;

// Function to register our services
void setupServiceLocator() {
  // For pretty printing while debbuging
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}

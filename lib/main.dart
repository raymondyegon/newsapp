import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:newsapp/src/app.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup services
  setupServiceLocator();

  // Initialize firebase
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  Function originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    // Forward to original handler.
    originalOnError(errorDetails);
  };

  // Setup logger, only show warning and higher in release mode.
  if (kReleaseMode) {
    Logger.level = Level.warning;
  } else {
    Logger.level = Level.debug;
  }

  // Set the orientation to potrait and start the app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runZonedGuarded(
        () {
          runApp(
            new StateContainer(
              child: new App(),
            ),
          );
        },
        FirebaseCrashlytics.instance.recordError,
      );
    },
  );
}

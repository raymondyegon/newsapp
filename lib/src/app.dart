import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/screens/feed/single_feed.dart';
import 'package:newsapp/src/screens/homepage/homepage.dart';
import 'package:sizer/sizer.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            //initialize SizerUtil for responsive ui and global access
            SizerUtil().init(constraints, orientation);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              initialRoute: '/',
              navigatorObservers: <NavigatorObserver>[observer],
              theme: ThemeData(
                primaryColor: StateContainer.of(context).theme.primary,
                backgroundColor: StateContainer.of(context).theme.background,
                textTheme: GoogleFonts.ibmPlexSansTextTheme(),
                fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
              ),
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/':
                    return MaterialPageRoute(
                      settings: settings,
                      builder: (_) => HomePage(),
                    );

                  case '/article':
                    return MaterialPageRoute(
                      settings: settings,
                      builder: (_) => SingleFeed(),
                    );

                  default:
                    return null;
                }
              },
            );
          },
        );
      },
    );
  }
}

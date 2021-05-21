import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:newsapp/src/common/theme.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/service_locator.dart';

class _InheritedStateContainer extends InheritedWidget {
  // Data is your entire state.
  final StateContainerState data;

  // You must pass through a child and your state.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;

  StateContainer({@required this.child});

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

/// App InheritedWidget
/// This is where we handle the global state and also where
/// we interact with the api's and make requests/handle+propagate responses
///
/// Basically the central hub behind the entire app
class StateContainerState extends State<StateContainer> {
  //To pretty log what we want
  final Logger log = sl.get<Logger>();

  // To acces the app theme
  BaseTheme theme = BaseTheme();

  // Where we store our articles
  List<ArticleModel> articles = [
    ArticleModel(
      id: '60a68f975deb17001cdedc98',
      newsSite: 'SpaceNews',
      publishedAt: 'May 20, 2021',
      title:
          "Europe making progress on sovereign LEO constellation as OneWeb and Starlink race ahead",
      summary:
          'The industry consortium devising a satellite network to keep the European Union from falling too far behind the megaconstellation goldrush is weeks away from nailing down key criteria.',
      url:
          "https://spacenews.com/europe-making-progress-on-sovereign-leo-constellation-as-oneweb-and-starlink-race-ahead/",
      imageUrl:
          "https://spacenews.com/wp-content/uploads/2021/04/Oneweb-launch2-scaled.jpeg",
    ),
    ArticleModel(
      id: "60a688925deb17001cdedc97",
      newsSite: 'NASA',
      publishedAt: 'May 20, 2021',
      title: "Salts Could Be Important Piece of Martian Organic Puzzle",
      summary:
          "A NASA team has found that organic, or carbon-containing, salts are likely present on Mars, with implications for the Red Planet's past habitability.",
      url: "https://mars.nasa.gov/news/8950/",
      imageUrl:
          "https://mars.nasa.gov/system/news_items/main_images/8950_1-Curiosity's-Color-View-768.jpg",
    ),
    ArticleModel(
      id: "60a51fa01fbdc6001d5d8fdd",
      newsSite: 'NASA Speceflight',
      publishedAt: 'May 20, 2021',
      title:
          "China scrubs second launch attempt of Tianzhou 2, first cargo launch to new station",
      summary:
          "China has scrubbed the second launch attempt in as many days of its Tianzhou 2 cargo mission to its new space station. Liftoff was expected Thursday, 20 May at 17:09 UTC / 13:09 EDT aboard a Chang Zheng 7 rocket. Wednesday’s launch attempt (UTC) was also scrubbed due a reported technical issue.",
      url: "https://www.nasaspaceflight.com/2021/05/tianzhou-2-launch/",
      imageUrl:
          "https://www.nasaspaceflight.com/wp-content/uploads/2021/05/CZ-7-1.jpg",
    ),
  ];

  // Where we store our articles
  List<ArticleModel> favorites = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:newsapp/src/common/theme.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/network/api_service.dart';
import 'package:newsapp/src/service_locator.dart';
import 'package:newsapp/src/utils/sharedprefsutil.dart';

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

  // Where we store our favorite articles
  List<ArticleModel> favorites = [];

  // The List of ID's of our favorite articles
  List<String> favoritesId = [];

  @override
  void initState() {
    super.initState();

    _registerControllers();
  }

  /// We register our controller used in pagination
  void _registerControllers() {
    // Setup listener to get new articles
    newsFeedpagingController.addPageRequestListener(
      (pageKey) {
        _fetchArticles(pageKey);
      },
    );

    // Setup listener to get fav articles
    newsFavpagingController.addPageRequestListener(
      (pageKey) {
        _fetchFavArticles(pageKey);
      },
    );
  }

  /// This is useful for debugging when we want to clear all favorites from DB
  /// Don't call it in production
  // ignore: unused_element
  Future<void> _removeAll() async {
    for (String fav in favoritesId) {
      await sl.get<SharedPrefsUtil>().removeFavorite(fav);
    }
  }

  /// Function to get our favorite ID's from database
  Future<void> _getFavorites() async {
    await sl.get<SharedPrefsUtil>().getFavorites().then(
      (List<String> result) {
        setState(
          () {
            favoritesId.addAll(result.where((element) => element != 'null'));
          },
        );

        /// we confirm the length
        log.d(favoritesId.length);
      },
    );
  }

  void toggleFavorite(ArticleModel article) async {
    if (favoritesId.contains(article.id)) {
      await sl.get<SharedPrefsUtil>().removeFavorite(article.id).then(
        (_) {
          setState(
            () {
              favoritesId.remove(article.id);

              favorites.removeWhere((articl) => articl.id == article.id);
            },
          );
          newsFavpagingController.itemList = favorites;
          log.d(favoritesId.length);
        },
      );
    } else {
      await sl.get<SharedPrefsUtil>().setFavorite(article.id).then(
        (_) {
          setState(
            () {
              favoritesId.add(article.id);

              favorites.add(article);
            },
          );
          newsFavpagingController.itemList = favorites;
          log.d(favoritesId.length);
          // newsFavpagingController.refresh();
        },
      );
    }
  }

  // We setup our news feed controller for infinite scrolling
  final PagingController<int, ArticleModel> newsFeedpagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 1);

  // Get latest articles
  Future<void> _fetchArticles(int pageKey) async {
    try {
      List<ArticleModel> newArticles =
          await sl.get<ApiService>().getArticles(paginate: pageKey);

      newsFeedpagingController.appendPage(
          newArticles, pageKey + newArticles.length);
    } catch (error) {
      log.e(error);
      newsFeedpagingController.error = error;
    }
  }

  // We setup our favorite articles controller for infinite scrolling
  final PagingController<int, ArticleModel> newsFavpagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 2);

  /// Before we process our first request we first get our favorite ID's from storage
  bool _firstLoading = true;

  // Get Other fav articles
  Future<void> _fetchFavArticles(int pageKey) async {
    try {
      if (_firstLoading) {
        await _getFavorites();
        _firstLoading = false;
      }

      log.d(pageKey);

      log.d(favoritesId.length);

      //We confirm if the length of favorites loaded is less than the number we have in our storage
      if (favorites.length < favoritesId.length) {
        // We get the difference in length of our favorite list and the our current pagination key
        int _dif = favoritesId.length - pageKey;

        log.d(_dif);

        // if the difference is greater than 4 We added the pagination key by 4
        // or else this means that we have less than 4 elements to get then we assign the remainingin the list
        int _next = _dif >= 4 ? pageKey + 4 : favoritesId.length;

        // We first check confirm the difference is greater than zero
        if (_dif > 0) {
          // We create an empty list where we will append all our articles before passing them
          List<ArticleModel> _result = [];

          log.d(_next);

          // Our function to get the data from our APi
          await Future.delayed(Duration(milliseconds: 1)).then((_) async {
            for (int i = pageKey; i < _next; i++) {
              log.d(i);

              ArticleModel _data = await sl
                  .get<ApiService>()
                  .getSingleArticle(id: favoritesId[i]);

              _result.addAll([_data]);
            }
          });

          /// We then append all data to our favorites list state
          favorites.addAll(_result);

          // We set our next pagination number according to our previous calculation
          newsFavpagingController.nextPageKey = _next;

          // Here we remove any duplicates that might have occured
          final ids = favorites.map((e) => e.id).toSet();

          favorites.retainWhere((x) => ids.remove(x.id));

          // we then update our controller with the latest favorites from our state
          newsFavpagingController.itemList = favorites;

          // We confirm the list that we have
          log.d(favorites.toList().toString());
        } else {
          // If the difference was zero then we don't have any favorites in our database
          // and thus we set stop our loader and pass an empty list
          newsFavpagingController.nextPageKey = null;

          newsFavpagingController.itemList = [];
        }
      } else {
        // We then confirm again if our Listner is null and assign it to an empyt list in-order to stop our loading indicator
        if (newsFavpagingController.itemList == null) {
          newsFavpagingController.itemList = [];
        }

        // We set nextpagekey to null to mark the end of our articles.
        newsFavpagingController.nextPageKey = null;
      }
    } catch (error) {
      /// We log an error that might occur
      log.e(error);
      newsFavpagingController.error = error;
    }
  }

  @override
  void dispose() {
    newsFeedpagingController.dispose();
    newsFavpagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

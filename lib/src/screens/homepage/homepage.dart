import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/screens/favorites/favorites.dart';
import 'package:newsapp/src/screens/feed/feed.dart';
import 'package:newsapp/src/screens/search/search_feed.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // To check the current pressed bottom bar item
  int _currentNav = 0;

  // To check whether search page is visible
  bool _isSearchVisible;

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
    });
  }

  @override
  void initState() {
    _isSearchVisible = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return Scaffold(
      backgroundColor: _theme.gray50,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              spreadRadius: 0,
              blurRadius: 4,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex: _currentNav,
            selectedItemColor: _theme.gray900,
            selectedIconTheme: IconThemeData(
              color: _theme.primary,
              size: 18.0.sp,
            ),
            selectedLabelStyle: AppStyles.textStyleSelected(context),
            unselectedIconTheme: IconThemeData(
              color: _theme.gray400,
              size: 18.0.sp,
            ),
            unselectedItemColor: _theme.gray700,
            unselectedLabelStyle: AppStyles.textStyleUnselected(context),
            onTap: (int selected) {
              setState(() {
                _currentNav = selected;

                if (_isSearchVisible == true) {
                  _isSearchVisible = !_isSearchVisible;
                }
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Feed',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Visibility(
          visible: _isSearchVisible,
          replacement: IndexedStack(
            index: _currentNav,
            children: [
              Feed(
                searchPressed: _toggleSearch,
              ),
              Favorite(
                searchPressed: _toggleSearch,
              ),
            ],
          ),
          child: SearchFeed(
            searchCancelled: _toggleSearch,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // To check the current pressed bottom bar item
  int _currentNav = 0;

  @override
  Widget build(BuildContext context) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return Scaffold(
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
            selectedItemColor: _theme.backgroundDark,
            selectedIconTheme: IconThemeData(
              color: _theme.primary,
              size: 18.0.sp,
            ),
            selectedLabelStyle: AppStyles.textStyleSelected(context),
            unselectedIconTheme: IconThemeData(
              color: _theme.iconGrey,
              size: 18.0.sp,
            ),
            unselectedItemColor: _theme.greyDark,
            unselectedLabelStyle: AppStyles.textStyleUnselected(context),
            onTap: (int selected) {
              if (selected != 2) {
                setState(() {
                  _currentNav = selected;
                });
              }
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';

class ArticleFormater {
  static Widget titleFormater({
    @required String title,
    @required BuildContext context,
    @required String searched,
  }) {
    return Text.rich(
      TextSpan(
        style: AppStyles.textStyleFeedTitle(context),
        children: title.split(' ').map(
          (String word) {
            return TextSpan(
              text: '$word ',
              style: word.toLowerCase() == searched.toLowerCase()
                  ? TextStyle(
                      color: StateContainer.of(context).theme.primary,
                    )
                  : TextStyle(),
            );
          },
        ).toList(),
      ),
    );
  }

  static Icon getIcon({
    @required BuildContext context,
    @required String id,
  }) {
    List<String> favorites = StateContainer.of(context).favoritesId;

    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return Icon(
      favorites.contains(id) ? Icons.favorite : Icons.favorite_border,
      color: favorites.contains(id) ? _theme.primary : _theme.gray500,
    );
    //  ;
  }

  static bool isFavorite({
    @required BuildContext context,
    @required String id,
  }) {
    List<String> favorites = StateContainer.of(context).favoritesId;

    return favorites.contains(id);
  }
}

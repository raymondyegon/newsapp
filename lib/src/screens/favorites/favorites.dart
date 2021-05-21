import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/widgets/article_feed.dart';

class Favorite extends StatefulWidget {
  final Function searchPressed;

  Favorite({this.searchPressed});

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    List<ArticleModel> _articles = StateContainer.of(context).favorites;

    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return ArticleFeedUtil.articleFeedList(
      articles: _articles,
      context: context,
      title: 'Favorites',
      searchPressed: widget.searchPressed,
      description: 'Favorite articles',
      zeroArticlesDescription: 'You don\'t have favorites yet.',
      icon: Icons.favorite,
      zeroDescriptionWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tap on the ',
            style: AppStyles.textStyleFavoriteHow(context),
          ),
          Icon(
            Icons.favorite_border,
            color: _theme.primary,
          ),
          Text(
            ' to mark an article as a favorite.',
            style: AppStyles.textStyleFavoriteHow(context),
          ),
        ],
      ),
    );
  }
}

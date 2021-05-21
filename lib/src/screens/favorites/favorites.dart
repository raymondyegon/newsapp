import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/widgets/article_feed.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    List<ArticleModel> _articles = StateContainer.of(context).articles;

    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return ArticleFeedUtil.articleFeedList(
      articles: _articles,
      context: context,
      title: 'Favorites',
      description: 'Favorite articles',
      zeroArticlesDescription: 'You don\'t have favorites yet.',
      icon: Icons.favorite,
      zeroDescriptionWidget: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tap on the ',
          ),
          Icon(
            Icons.favorite_border,
            color: _theme.primary,
          ),
          Text(
            'to mark an article as a favorite.',
          ),
        ],
      ),
    );
  }
}

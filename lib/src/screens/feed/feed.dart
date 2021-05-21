import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/widgets/article_feed.dart';

class Feed extends StatefulWidget {
  final Function searchPressed;

  Feed({this.searchPressed});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    List<ArticleModel> _articles = StateContainer.of(context).articles;

    return ArticleFeedUtil.articleFeedList(
      articles: _articles,
      context: context,
      searchPressed: widget.searchPressed,
      title: 'Feed',
      description: 'News feed',
      zeroArticlesDescription: 'There are no news yet.',
      icon: Icons.text_snippet_rounded,
    );
  }
}

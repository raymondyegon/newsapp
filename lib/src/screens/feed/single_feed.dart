import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/utils/article_format_utils.dart';
import 'package:sizer/sizer.dart';

class SingleFeed extends StatefulWidget {
  @override
  _SingleFeedState createState() => _SingleFeedState();
}

class _SingleFeedState extends State<SingleFeed> {
  @override
  Widget build(BuildContext context) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    ArticleModel article =
        ModalRoute.of(context).settings.arguments as ArticleModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Article',
          style: AppStyles.textStyleAppbar(),
        ),
        backgroundColor: _theme.gray900,
      ),
      backgroundColor: _theme.gray50,
      body: SafeArea(
        child: Container(
          height: 100.0.h,
          width: 100.0.w,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                    )
                  ],
                ),
                height: 100.0.h < 667 ? 300 : 40.0.h,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: 100.0.h < 667 ? 260 : 37.0.h,
                      imageUrl: article.imageUrl,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(_theme.primary),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(15),
                          //   topRight: Radius.circular(15),
                          // ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          Center(child: new Icon(Icons.error)),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        // height: 80,
                        width: 100.0.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.0.w,
                          vertical: 0.8.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: AppStyles.textStyleFeedTitle(context),
                            ),
                            Divider(
                              color: _theme.gray200,
                              height: 2.5.h,
                              thickness: 1.5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: _theme.gray500,
                                ),
                                SizedBox(
                                  width: 2.5.w,
                                ),
                                Text(
                                  article.publishedAt,
                                  style: AppStyles.textStyleFeedDate(context),
                                ),
                                SizedBox(
                                  width: 6.5.w,
                                ),
                                IconButton(
                                  onPressed: () {
                                    StateContainer.of(context)
                                        .toggleFavorite(article);
                                  },
                                  icon: ArticleFormater.getIcon(
                                    context: context,
                                    id: article.id,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.0.w,
                    vertical: 1.4.h,
                  ),
                  child: Text(
                    article.summary,
                    style: AppStyles.textStyleArticleSummary(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

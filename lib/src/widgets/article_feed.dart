import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/utils/article_format_utils.dart';
import 'package:sizer/sizer.dart';

class ArticleFeedUtil {
  static Widget articleFeedList({
    @required List<ArticleModel> articles,
    @required BuildContext context,
    @required String title,
    @required String description,
    @required String zeroArticlesDescription,
    @required IconData icon,
    Function searchPressed,
    Widget zeroDescriptionWidget,
  }) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return Container(
      height: 100.0.h,
      width: 100.0.w,
      color: _theme.primary,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppStyles.textStyleTitleTop(),
                ),
                IconButton(
                  onPressed: searchPressed,
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.search,
                    size: 17.0.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _theme.gray50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 3.0.w,
                vertical: 1.5.h,
              ),
              width: 100.0.w,
              child: articles?.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _theme.gray100,
                          ),
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.only(bottom: 15),
                          child: Icon(
                            icon,
                            color: _theme.gray300,
                            size: 80.0.sp,
                          ),
                        ),
                        Text(
                          zeroArticlesDescription,
                          style: AppStyles.textStyleNoArticles(context),
                        ),
                        Visibility(
                          visible: zeroDescriptionWidget != null,
                          child: zeroDescriptionWidget,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: AppStyles.textStylePageDescription(context),
                        ),
                        SizedBox(
                          height: 2.5.h,
                        ),
                        Expanded(
                          child: ListView.separated(
                            itemCount: articles.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 1.5.h,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              ArticleModel _article = articles[index];

                              return articleFeed(
                                article: _article,
                                context: context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }

  static Widget articleFeed({
    @required ArticleModel article,
    @required BuildContext context,
    Widget titleWidget,
  }) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/article', arguments: article);
      },
      child: Container(
        key: Key(article.id),
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
        height: 300,
        child: Stack(
          children: [
            CachedNetworkImage(
              height: 260,
              imageUrl: article.imageUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_theme.primary),
                  backgroundColor: Colors.white,
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget ??
                        Text(
                          article.title,
                          style: AppStyles.textStyleFeedTitle(context),
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
                          onPressed: () async {
                            StateContainer.of(context).toggleFavorite(article);
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
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:sizer/sizer.dart';

class ArticleFeedUtil {
  // static Widget

  static Widget articleFeed({
    @required ArticleModel article,
    @required BuildContext context,
  }) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    return InkWell(
      child: Container(
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
                  backgroundColor: _theme.primary,
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
              errorWidget: (context, url, error) => new Icon(Icons.error),
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                            color: _theme.gray500,
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

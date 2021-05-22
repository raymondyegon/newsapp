import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/widgets/article_feed.dart';
import 'package:sizer/sizer.dart';

class Feed extends StatefulWidget {
  final Function searchPressed;

  Feed({this.searchPressed});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
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
                  'Feed',
                  style: AppStyles.textStyleTitleTop(),
                ),
                IconButton(
                  onPressed: widget.searchPressed,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'News feed',
                    style: AppStyles.textStylePageDescription(context),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => StateContainer.of(context)
                            .newsFeedpagingController
                            .refresh(),
                      ),
                      child: PagedListView.separated(
                        pagingController:
                            StateContainer.of(context).newsFeedpagingController,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 1.5.h,
                          );
                        },
                        physics: BouncingScrollPhysics(),
                        builderDelegate:
                            PagedChildBuilderDelegate<ArticleModel>(
                          newPageProgressIndicatorBuilder: (_) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    _theme.primary),
                                backgroundColor: Colors.white,
                              ),
                            );
                          },
                          noItemsFoundIndicatorBuilder: (_) {
                            return Column(
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
                                    Icons.text_snippet_rounded,
                                    color: _theme.gray300,
                                    size: 80.0.sp,
                                  ),
                                ),
                                Text(
                                  'There are no news yet.',
                                  style: AppStyles.textStyleNoArticles(context),
                                ),
                              ],
                            );
                          },
                          firstPageErrorIndicatorBuilder: (_) {
                            return Column(
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
                                    Icons.text_snippet_rounded,
                                    color: _theme.gray300,
                                    size: 80.0.sp,
                                  ),
                                ),
                                Text(
                                  'There are no news yet.',
                                  style: AppStyles.textStyleNoArticles(context),
                                ),
                              ],
                            );
                          },
                          firstPageProgressIndicatorBuilder: (_) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    _theme.primary),
                                backgroundColor: Colors.white,
                              ),
                            );
                          },
                          itemBuilder: (context, item, index) {
                            return ArticleFeedUtil.articleFeed(
                              article: item,
                              context: context,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

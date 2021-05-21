import 'package:flutter/material.dart';
import 'package:newsapp/src/appstate_container.dart';
import 'package:newsapp/src/common/styles.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/utils/title_search_formater.dart';
import 'package:newsapp/src/widgets/article_feed.dart';
import 'package:sizer/sizer.dart';

class SearchFeed extends StatefulWidget {
  final Function searchCancelled;

  SearchFeed({this.searchCancelled});

  @override
  _SearchFeedState createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  ValueNotifier<List<ArticleModel>> filtered =
      ValueNotifier<List<ArticleModel>>([]);

  TextEditingController searchController = TextEditingController();

  FocusNode searchFocus = FocusNode();

  bool searching = false;

  @override
  void dispose() {
    super.dispose();
    searchFocus.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The current app theme
    var _theme = StateContainer.of(context).theme;

    // We use this for testing
    List<ArticleModel> _articles = StateContainer.of(context).articles;

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
                  "Search",
                  style: AppStyles.textStyleTitleTop(),
                ),
                IconButton(
                  onPressed: widget.searchCancelled,
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.close,
                    size: 17.0.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.5.w,
            ),
            child: TextField(
              cursorColor: Colors.white,
              controller: searchController,
              focusNode: searchFocus,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.0.sp,
              ),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                fillColor: Colors.black.withOpacity(0.3),
              ),
              onChanged: (String term) {
                if (term.length > 0) {
                  searching = true;
                  filtered.value = [];

                  _articles.forEach(
                    (article) {
                      if (article.title.toLowerCase().contains(
                            term.toLowerCase(),
                          )) {
                        filtered.value.add(article);
                      }
                    },
                  );
                } else {
                  searching = false;
                  filtered.value = [];
                }
              },
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
              margin: EdgeInsets.only(top: 2.5.h),
              padding: EdgeInsets.symmetric(
                horizontal: 3.0.w,
                vertical: 1.5.h,
              ),
              width: 100.0.w,
              child: ValueListenableBuilder<List<ArticleModel>>(
                  valueListenable: filtered,
                  builder:
                      (BuildContext context, List<ArticleModel> result, _) {
                    return result?.length == 0
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
                                  Icons.search,
                                  color: _theme.gray300,
                                  size: 80.0.sp,
                                ),
                              ),
                              Text(
                                "There are no results for this search.",
                                style: AppStyles.textStyleNoArticles(context),
                              ),
                              Text(
                                'Try searching another word.',
                                style: AppStyles.textStyleFavoriteHow(context),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.5.h,
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: result.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      height: 1.5.h,
                                    );
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ArticleModel _article = result[index];

                                    return ArticleFeedUtil.articleFeed(
                                      article: _article,
                                      context: context,
                                      titleWidget: TitleFormater.format(
                                        title: _article.title,
                                        context: context,
                                        searched: searchController.value.text,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

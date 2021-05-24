import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newsapp/src/model/article_model.dart';

import '../utils/paging_controller_utils.dart';

void main() {
  group(
    'Test the Widget that previews article during pagination (From ArticleFeedUtil --> ArticleFeed )',
    () {
      testWidgets(
        'Test that the widget is formed using a unique key',
        (WidgetTester tester) async {
          final controllerLoadedWithFirstPage =
              buildPagingControllerWithPopulatedState(
            PopulatedStateOption.ongoingWithOnePage,
          );

          await _pumpPagedListView(
            tester: tester,
            pagingController: controllerLoadedWithFirstPage,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
            ),
          );

          final containerKey = find.byKey(Key('1'));

          // We test the container exists
          expect(containerKey, findsOneWidget);

          final titleText = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data.startsWith('title 1'),
          );

          expect(titleText, findsOneWidget);
        },
      );

      testWidgets(
        'We confirm that we have the calendar Icon displayed',
        (WidgetTester tester) async {
          final controllerLoadedWithFirstPage =
              buildPagingControllerWithPopulatedState(
            PopulatedStateOption.ongoingWithOnePage,
          );

          await _pumpPagedListView(
            tester: tester,
            pagingController: controllerLoadedWithFirstPage,
            separatorBuilder: (_, __) => const Divider(
              height: 1,
            ),
          );

          final calenderIcon = find.byIcon(Icons.calendar_today);

          expect(calenderIcon, findsWidgets);
        },
      );
    },
  );
}

Future<void> _pumpPagedListView({
  @required WidgetTester tester,
  @required PagingController<int, ArticleModel> pagingController,
  IndexedWidgetBuilder separatorBuilder,
}) =>
    tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: separatorBuilder == null
              ? PagedListView(
                  pagingController: pagingController,
                  physics: BouncingScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<ArticleModel>(
                    itemBuilder: _buildArticlePreview,
                  ),
                )
              : PagedListView.separated(
                  pagingController: pagingController,
                  physics: BouncingScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<ArticleModel>(
                    itemBuilder: _buildArticlePreview,
                    firstPageErrorIndicatorBuilder: (_) => Center(
                      child: Text("An error occured"),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      child: Text('No Items to display'),
                    ),
                  ),
                  separatorBuilder: separatorBuilder,
                ),
        ),
      ),
    );

Widget _buildArticlePreview(
  BuildContext context,
  ArticleModel article,
  int index,
) =>
    Container(
      key: Key(article.id),
      height: 100,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: article.imageUrl,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
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
            errorWidget: (context, url, error) => Center(
              child: new Icon(
                Icons.error,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                      ),
                      SizedBox(
                        width: 2.5,
                      ),
                      Text(
                        article.publishedAt,
                      ),
                      SizedBox(
                        width: 6.5,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: index.isEven
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );

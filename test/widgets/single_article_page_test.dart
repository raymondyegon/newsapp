import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/src/model/article_model.dart';

void main() {
  group(
    'Test the single page article',
    () {
      ArticleModel _article = ArticleModel(
        id: "1",
        newsSite: 'newsSite 1',
        publishedAt: 'May 20, 2021',
        imageUrl: 'image.com',
        url: 'article.com',
        title: 'title 1',
        summary: 'summary 1',
      );
      testWidgets(
        'Test all the article data is displayed',
        (WidgetTester tester) async {
          await _pumpSingleArticle(tester: tester, article: _article);

          final containerKey = find.byKey(Key('1'));

          // We test the container exists
          expect(containerKey, findsOneWidget);

          final titleText = find.byWidgetPredicate(
            (Widget widget) =>
                widget is Text && widget.data.startsWith('title 1'),
          );

          expect(titleText, findsOneWidget);

          final calenderIcon = find.byIcon(Icons.calendar_today);

          expect(calenderIcon, findsOneWidget);

          final dateText = find.byWidgetPredicate(
            (Widget widget) =>
                widget is Text && widget.data.startsWith('May 20, 2021'),
          );

          expect(dateText, findsOneWidget);

          final authorText = find.byWidgetPredicate(
            (Widget widget) =>
                widget is Text && widget.data.startsWith('By newsSite 1'),
          );

          expect(authorText, findsOneWidget);
        },
      );
    },
  );
}

Future<void> _pumpSingleArticle({
  @required WidgetTester tester,
  @required ArticleModel article,
}) =>
    tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: Container(
            key: Key(article.id),
            child: Column(
              children: [
                Container(
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
                              Text(
                                'By ${article.newsSite}',
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
                                    icon: Icon(Icons.favorite_border),
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
                  child: Text(
                    article.summary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

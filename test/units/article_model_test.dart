import 'package:newsapp/src/model/article_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'Testing the Article Model class ',
    () {
      // A single article
      ArticleModel article;

      // List of articles
      List<ArticleModel> articles;

      // A json of sample of API response
      Map<String, dynamic> json;

      // Load data before running any tests
      setUpAll(
        () {
          article = ArticleModel(
            id: '60a68f975deb17001cdedc98',
            newsSite: 'SpaceNews',
            publishedAt: 'May 20, 2021',
            title:
                "Europe making progress on sovereign LEO constellation as OneWeb and Starlink race ahead",
            summary:
                'The industry consortium devising a satellite network to keep the European Union from falling too far behind the megaconstellation goldrush is weeks away from nailing down key criteria.',
            url:
                "https://spacenews.com/europe-making-progress-on-sovereign-leo-constellation-as-oneweb-and-starlink-race-ahead/",
            imageUrl:
                "https://spacenews.com/wp-content/uploads/2021/04/Oneweb-launch2-scaled.jpeg",
          );

          articles = [
            ArticleModel(
              id: '60a68f975deb17001cdedc98',
              newsSite: 'SpaceNews',
              publishedAt: 'May 20, 2021',
              title:
                  "Europe making progress on sovereign LEO constellation as OneWeb and Starlink race ahead",
              summary:
                  'The industry consortium devising a satellite network to keep the European Union from falling too far behind the megaconstellation goldrush is weeks away from nailing down key criteria.',
              url:
                  "https://spacenews.com/europe-making-progress-on-sovereign-leo-constellation-as-oneweb-and-starlink-race-ahead/",
              imageUrl:
                  "https://spacenews.com/wp-content/uploads/2021/04/Oneweb-launch2-scaled.jpeg",
            ),
            ArticleModel(
              id: "60a688925deb17001cdedc97",
              newsSite: 'NASA',
              publishedAt: 'May 20, 2021',
              title: "Salts Could Be Important Piece of Martian Organic Puzzle",
              summary:
                  "A NASA team has found that organic, or carbon-containing, salts are likely present on Mars, with implications for the Red Planet's past habitability.",
              url: "https://mars.nasa.gov/news/8950/",
              imageUrl:
                  "https://mars.nasa.gov/system/news_items/main_images/8950_1-Curiosity's-Color-View-768.jpg",
            ),
            ArticleModel(
              id: "60a51fa01fbdc6001d5d8fdd",
              newsSite: 'NASA Speceflight',
              publishedAt: 'May 20, 2021',
              title:
                  "China scrubs second launch attempt of Tianzhou 2, first cargo launch to new station",
              summary:
                  "China has scrubbed the second launch attempt in as many days of its Tianzhou 2 cargo mission to its new space station. Liftoff was expected Thursday, 20 May at 17:09 UTC / 13:09 EDT aboard a Chang Zheng 7 rocket. Wednesday’s launch attempt (UTC) was also scrubbed due a reported technical issue.",
              url: "https://www.nasaspaceflight.com/2021/05/tianzhou-2-launch/",
              imageUrl:
                  "https://www.nasaspaceflight.com/wp-content/uploads/2021/05/CZ-7-1.jpg",
            ),
          ];

          json = {
            "id": "60a92b8a5deb17001cdedcb0",
            "title": "SpaceShipTwo makes first flight to space from New Mexico",
            "url":
                "https://spacenews.com/spaceshiptwo-makes-first-flight-to-space-from-new-mexico/",
            "imageUrl":
                "https://spacenews.com/wp-content/uploads/2020/06/ss2-wk2-release-june2020.jpg",
            "newsSite": "SpaceNews",
            "summary":
                "Virgin Galactic’s SpaceShipTwo made its first flight to space in more than two years May 22, completing the first in a series of four suborbital flights planned by the company over the next several months.",
            "publishedAt": "2021-05-22T16:04:26.000Z",
            "updatedAt": "2021-05-22T16:47:49.491Z",
            "featured": false,
            "launches": [
              {
                "id": "182a1c2f-c36a-4444-8599-448516ac1c2d",
                "provider": "Launch Library 2"
              }
            ],
            "events": []
          };
        },
      );
      test(
        'An Article model instance is created ',
        () {
          expect(article.runtimeType, ArticleModel);
        },
      );

      test(
        'Test a list of the articles',
        () {
          // We check the length is 3
          expect(articles.length, 3);

          // We remove one element
          articles.removeLast();

          // We confirm the element was removed
          expect(articles.length, 2);
        },
      );

      test(
        'Test an Article model is created from json object',
        () {
          var articleJson = ArticleModel.fromJson(json);

          // We check if it's empty
          expect(articleJson.id, isNotNull);

          // We confirm it is an ArticleModel instance
          expect(articleJson.runtimeType, ArticleModel);
        },
      );

      test(
        'Test we can get article Id separately from the json',
        () {
          // Make the ID be null
          json['id'] = null;

          // Pass in the Id separately
          var articleJson = ArticleModel.fromJson(json, id: 'newId');

          // We check if they match
          expect(articleJson.id, 'newId');
        },
      );

      test(
        'Test to string returns the Id of articles',
        () {
          // make the article be a string
          String idString = article.toString();

          expect(idString, '60a68f975deb17001cdedc98');
        },
      );
    },
  );
}

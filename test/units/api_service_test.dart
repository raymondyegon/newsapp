import 'package:flutter_test/flutter_test.dart';
import 'package:newsapp/src/model/article_model.dart';
import 'package:newsapp/src/network/api_service.dart';
import 'package:newsapp/src/service_locator.dart';

void main() {
  group(
    'Test Api Calls and Responses',
    () {
      ApiService _api;

      setUpAll(
        () {
          // We call these to register the services
          setupServiceLocator();

          // Create APi service instance
          _api = sl.get<ApiService>();
        },
      );

      test(
        'Test API call to get only a single article.',
        () async {
          // Make the api call using an Id
          var data =
              await _api.getSingleArticle(id: '60a68f975deb17001cdedc98');

          // Verify the data is not null
          expect(data, isNotNull);

          // Verify the data type is an ArticleModel
          expect(data.runtimeType, ArticleModel);
        },
      );

      test(
        'Test API call to get a list of articles',
        () async {
          // Make the api call to get the first ten articles
          var data = await _api.getArticles(paginate: 10);

          // Get the next 10 articles
          var data2 = await _api.getArticles(paginate: 20);

          // Verify the data is not null
          expect(data, isNotNull);

          // Verify it contains ten articles
          expect(data.length, 10);

          // Verify the data2 is not null
          expect(data2, isNotNull);

          // Verify data2 contains ten articles
          expect(data2.length, 10);

          // Verify that the two pages do not match
          expect(data.toString() != data2.toString(), true);
        },
      );
    },
    // skip: true,
  );
}

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:logger/logger.dart';
import 'package:newsapp/src/service_locator.dart';
import 'package:newsapp/src/model/article_model.dart';

/// Api Service singleton
class ApiService {
  // To log our responses
  final Logger log = sl.get<Logger>();

  //  To cache our responses
  DioCacheManager _dioCacheManager;

  Options _cacheOptions;

  Dio _dio;

  // Constructor
  ApiService() {
    _dioCacheManager = DioCacheManager(
      CacheConfig(
        defaultRequestMethod: 'GET',
      ),
    );

    _cacheOptions = buildCacheOptions(
      Duration(
        days: 1,
      ), // Within the first day we return data from cache directly
      maxStale: Duration(
        days: 7,
      ), // After the first day we first check the network and if it fails we use data from cache.. After 7 days we delete the cache
      forceRefresh: true,
    );

    _dio = Dio();

    _dio.interceptors.add(_dioCacheManager.interceptor);
  }

  /// Get news articles feed
  Future<List<ArticleModel>> getArticles({int paginate}) async {
    int page = paginate ?? 0;

    Response response = await _dio.get(
      'https://spaceflightnewsapi.net/api/v2/articles?_limit=10&_start=$page',
      options: _cacheOptions,
    );

    // Check the status code
    log.d(response.statusCode);

    // Log the body data
    log.d(response.data);

    if (response.statusCode == 200) {
      var articles = response.data;

      List<ArticleModel> data = List<ArticleModel>.generate(
          articles.length, (index) => ArticleModel.fromJson(articles[index]));

      return data;
    } else {
      throw {
        'statusCode': response.statusCode,
        'message': response.data,
      };
    }
  }

  /// Get a single article using it's id
  Future<ArticleModel> getSingleArticle({String id}) async {
    Response response = await _dio.get(
      'https://spaceflightnewsapi.net/api/v2/articles/$id',
      options: _cacheOptions,
    );

    // Check the status code
    log.d(response.statusCode);

    // Log the body data
    log.d(response.data);

    if (response.statusCode == 200) {
      return ArticleModel.fromJson(response.data);
    } else {
      throw {
        'statusCode': response.statusCode,
        'message': response.data,
      };
    }
  }
}

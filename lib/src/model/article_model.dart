import 'package:intl/intl.dart';

class ArticleModel {
  final String id;
  final String title;
  final String url;
  final String imageUrl;
  final String newsSite;
  final String summary;
  final String publishedAt;

  ArticleModel({
    this.id,
    this.title,
    this.url,
    this.imageUrl,
    this.newsSite,
    this.summary,
    this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json, {String id}) {
    return ArticleModel(
      id: json['id'] ?? id,
      title: json['title'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      newsSite: json['newsSite'],
      summary: json['summary'],
      publishedAt: DateFormat.yMMMMd('en_US')
          .format(DateTime.tryParse(json['publishedAt'])),
    );
  }

  set id(String idd) => id = idd;

  @override
  String toString() {
    return id;
  }
}

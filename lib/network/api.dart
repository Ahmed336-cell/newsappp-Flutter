import 'package:dio/dio.dart';
import '../model/news.dart';

class NewsService {
  final String _apiKey = '4288b50766b64144af28c4801a47e195';
  final Dio _dio = Dio();

  Future<List<NewsArticle>> fetchNews(String paramter) async {
    try {
      final response = await _dio.get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          'q': paramter,
          'apiKey': _apiKey,
        },
      );

      switch (response.statusCode) {
        case 200:
          final List<dynamic> articles = response.data['articles'];
          return articles.map((json) => NewsArticle.fromJson(json)).toList();
        case 400:
          throw Exception('Bad request');
        case 401:
          throw Exception('Unauthorized - Check your API key');
        case 500:
          throw Exception('Server error - Please try again later');
        default:
          throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}

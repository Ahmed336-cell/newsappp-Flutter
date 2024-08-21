import 'package:intl/intl.dart';
class NewsArticle {
  final String title;
  final String author;
  final String url;
  final String description;
  final String urlToImage;
  final String publishedAt;

  NewsArticle({
    required this.title,
    required this.author,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.description
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    // Parsing the publishedAt field to a DateTime object
    DateTime parsedDate = DateTime.parse(json['publishedAt']);
    // Formatting the date to a readable format
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);

    return NewsArticle(
      title: json['title'],
      author: json['author'] ?? 'Unknown',
      url: json['url'],
      description: json['description']?? 'No description available',
      urlToImage: json['urlToImage'] ?? 'https://ih1.redbubble.net/image.4905811447.8675/flat,750x,075,f-pad,750x1000,f8f8f8.jpg',
      publishedAt: formattedDate, // Use the formatted date here
    );
  }
}

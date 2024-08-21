import 'package:flutter/material.dart';
import 'package:newsappp/ui/detailsScreen.dart';

import '../model/news.dart';
import '../network/api.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsArticle>> _newsArticles;

  @override
  void initState() {
    super.initState();
    _newsArticles = NewsService().fetchNews('sport');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All the news', style: TextStyle(color: Colors
            .white),),
        backgroundColor: Colors.orange,

      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: _newsArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final article = snapshot.data![index];
                return ListTile(
                    leading: Image.network(article.urlToImage,
                      width: 170,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    title: Text(article.title),
                    subtitle: Text('By ${article.author}'),
                    onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Detailsscreen(article: article))
                )
                );
              },
            );
          }
        },
      ),
    );
  }

}

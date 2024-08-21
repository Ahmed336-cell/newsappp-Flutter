import 'package:flutter/material.dart';
import 'package:newsappp/model/news.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailsscreen extends StatelessWidget {
  const Detailsscreen({super.key, required this.article});
 final  NewsArticle article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text(article.title, style: const TextStyle(color: Colors.white),
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        textWidthBasis: TextWidthBasis.longestLine,
      ),
      backgroundColor: Colors.orange,
      ) ,

      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(article.title,style: const TextStyle(color: Colors.black , fontWeight: FontWeight.bold,
              fontSize: 25,
              ),
              textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              height: 20,
              thickness: 3,
              color: Colors.grey,
              indent: 25,
              endIndent: 25,
            ),
            ListTile(

              leading: const Icon(Icons.watch_later_outlined,size: 30,),
              title: Text(article.publishedAt , style: const TextStyle(fontSize: 18),
              ),
            ),
            Image(image: NetworkImage(article.urlToImage,
            ),
            height: 150,
              width: 350,
              fit: BoxFit.fill,
            ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Author:${article.author}" , style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(article.description,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,

              ),
            ),

            MaterialButton(onPressed: (){
              _launchURL(article.url );
            }
            ,
              color: Colors.orange,
              textColor: Colors.white,child: const Text("Read more"),
            )
          ],
        ),
      )
    );
  }
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      print('Could not launch $url');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:finance_tracker/model/article_model.dart';

    class ApiService {
    final endPointUrl = "newsapi.org";
    final client = http.Client();
    
    Future<List<Article>> getArticle() async {
        
        final queryParameters = {
        'country': 'us',
        'category': 'business',
        'apiKey': '882a5a9ae20e4b6eae9b2e423b9d89e1'
        };
        
        final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
        final response = await client.get(uri);
        Map<String, dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json['articles'];
        List<Article> articles = body.map((dynamic item) => Article.fromJson(item)).toList();
        return articles;
    }
}
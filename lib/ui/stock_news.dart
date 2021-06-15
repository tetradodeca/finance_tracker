import 'package:finance_tracker/model/article_model.dart';
import 'package:finance_tracker/net/news_api.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/ui/customNewsTile.dart';

class StockNews extends StatefulWidget {
  StockNews({key}) : super(key: key);

  @override
  _StockNewsState createState() => _StockNewsState();
}

class _StockNewsState extends State<StockNews> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Business News'),
        ),
        body: FutureBuilder(
            future: client.getArticle(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                List<Article>? articles = snapshot.data;
                return ListView.builder(
                  itemCount: articles!.length,
                  itemBuilder: (context, i) {
                    return Container(
                        color: Colors.black,
                        child: customListTile(
                          articles[i], context
                        ));
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

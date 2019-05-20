import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/news_data.dart';
import 'package:url_launcher/url_launcher.dart';

import 'database_helpers.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {

  List colors = [
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.pink,
    Colors.indigo
  ];
  Random random = new Random();

  List<News> _news = new List();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: createNewsWidget(_news, colors, random));
  }
}

Widget createNewsWidget(List<News> _news, List colors, Random random) {
  print("MyNews in widget " + _news.toString());
  return FutureBuilder(
    future: _query(_news),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if (!snapshot.hasData) return new Container();
      List<News> content = snapshot.data;
      print("Content" + content.toString());
      print("Content Lenght" + content.length.toString());
      return new ListView.builder(
        scrollDirection: Axis.vertical,
        padding: new EdgeInsets.all(6.0),
        itemCount: content.length,
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              color: colors[random.nextInt(7)],
              elevation: 1.7,
              child: new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new Column(
                  children: [
                    new Row(
                      children: <Widget>[
                        new Padding(
                          padding: new EdgeInsets.only(left: 4.0),
                          child: new Text(
                            content[index].publishedAt,
                            style: new TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      children: [
                        new Expanded(
                          child: new GestureDetector(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Padding(
                                  padding: new EdgeInsets.only(
                                      left: 4.0,
                                      right: 8.0,
                                      bottom: 8.0,
                                      top: 8.0),
                                  child: new Text(
                                    content[index].title,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                                new Padding(
                                  padding: new EdgeInsets.only(
                                      left: 4.0, right: 4.0, bottom: 4.0),
                                  child: new Text(
                                    content[index].description,
                                    style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              launch(content[index].url);
                            },
                          ),
                        ),
                        new Column(
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.only(top: 8.0),
                              child: new SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: new Image.network(
                                  content[index].urlToImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

Future<List<News>> _query(List<News> news) async {
  DatabaseHelper helper = DatabaseHelper.instance;
  final records = (await helper.queryNews());
  if (records.length > 0) {
    return records.map((c) => new News.fromMap(c)).toList();
  }
  return null;
}

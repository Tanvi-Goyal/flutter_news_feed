import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_news_feed/data/news_data.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'database_helpers.dart';
import 'modules/news_presenter.dart';

class NewsRoute extends StatefulWidget {
  @override
  NewsRouteState createState() => NewsRouteState();
}

class NewsRouteState extends State<NewsRoute> implements NewsListViewContract {
  NewsListPresenter _presenter;
  List<News> _news;

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


  NewsRouteState() {
    _presenter = new NewsListPresenter(this);
  }

  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _presenter.loadNews();
    _isLoading = true;
//    index = random.nextInt(3);

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: _isLoading
            ? new Center(
          child: new CircularProgressIndicator(),
        )
            : createNewsWidget());
  }

  Widget createNewsWidget() {
    return new ListView.builder(
      itemCount: _news == null ? 0 : _news.length,
      padding: new EdgeInsets.only(top: 50, bottom: 50, left: 10, right: 10),
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
                          _news[index].publishedAt,
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
                                  _news[index].title,
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
                                  _news[index].description,
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
                            launch(_news[index].url);
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
                                _news[index].urlToImage,
                                fit: BoxFit.cover,

                              ),
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              new GestureDetector(
                                child: new Padding(
                                    padding: new EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 5.0),
                                    child: buildButtonColumn(
                                        Icons.share)
                                ),
                                onTap: () {
                                  Share.share('Check out this news ' +
                                      _news[index].url);

//                                  share(_news[index].url);
                                },
                              ),
                              new GestureDetector(
                                child: new Padding(
                                    padding: new EdgeInsets.all(5.0),
                                    child: buildButtonColumn(
                                        Icons.bookmark_border)),
                                onTap: () {
                                  _onBookmarkTap(_news[index], context);
                                },
                              ),
                            ],
                          )
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
  }

  Column buildButtonColumn(IconData icon) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new Icon(icon, color: color),
      ],
    );
  }

  @override
  void onLoadNewsComplete(List<News> items) {
    // TODO: implement onLoadNewsComplete

    setState(() {
      _news = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadNewsError() {
    // TODO: implement onLoadNewsError
  }

  Future _onBookmarkTap(News news, BuildContext context) async {
    final snackBar = SnackBar(content: Text('Added to Bookmarks!'));
    Scaffold.of(context).showSnackBar(snackBar);

    News mynews = News();
    mynews.author = news.author;
    mynews.title = news.title;
    mynews.description = news.description;
    mynews.url = news.url;
    mynews.urlToImage = news.urlToImage;
    mynews.publishedAt = news.publishedAt;
    DatabaseHelper helper = DatabaseHelper.instance;
    int title = await helper.insert(mynews);
    print('inserted row: $title');
  }
}

import 'news_data.dart';

class MocknewsRepository implements NewsRepository{
  @override
  Future<List<News>> fetchNews() {
    // TODO: implement fetchNews
    return new Future.value(news);
  }

}

var news = <News> [

  new News(author: "Tanvi Goyal" ,title: "Sample News 1" , description: "It is a mock news for testing",
  url: "http://www.bbc.co.uk/news/uk-politics-48304867",
  urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/7DF9/production/_106994223_maycorbyn.jpg" ,
  publishedAt: "2019-05-17T02:47:51Z"),

  new News(author: "Tanvi Goyal" ,title: "Sample News 2" , description: "It is a mock news for testing",
      url: "http://www.bbc.co.uk/news/uk-politics-48304867",
      urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/7DF9/production/_106994223_maycorbyn.jpg" ,
      publishedAt: "2019-05-17T02:47:51Z"),

  new News(author: "Tanvi Goyal" ,title: "Sample News 3" , description: "It is a mock news for testing",
      url: "http://www.bbc.co.uk/news/uk-politics-48304867",
      urlToImage: "https://ichef.bbci.co.uk/news/1024/branded_news/7DF9/production/_106994223_maycorbyn.jpg" ,
      publishedAt: "2019-05-17T02:47:51Z"),

];
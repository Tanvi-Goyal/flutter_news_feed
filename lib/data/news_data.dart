class News {

  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;

  News({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt
  });

  News.fromMap(Map<String, dynamic> map) : author = map['author'],
  title = map['title'],
  description = map['description'],
  url = map['url'],
  urlToImage = map['urlToImage'],
  publishedAt = map['publishedAt'];

}

abstract class NewsRepository{
  Future<List<News>> fetchNews();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
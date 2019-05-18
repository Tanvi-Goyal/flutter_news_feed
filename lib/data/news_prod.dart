import 'news_data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class ProdNewsRepository implements NewsRepository{
  final String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=22920e566522494fbd2b629ad2461b8f";

  @override
  Future<List<News>> fetchNews() async {
    // TODO: implement fetchNews

    http.Response response = await http.get(url);
    var convertDataToJson = jsonDecode(response.body);
    final List responseBody = convertDataToJson['articles'];
    final statusCode = response.statusCode;

    if(statusCode != 200 || responseBody == null) {
      throw new FetchDataException("An error occured: [Status Code : $statusCode]");
    }

    return responseBody.map((c) => new News.fromMap(c)).toList();
  }

}
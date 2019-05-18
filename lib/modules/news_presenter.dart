import 'package:flutter_news_feed/data/news_data.dart';

import '../dependency_injection.dart';

abstract class NewsListViewContract {
  void onLoadNewsComplete(List<News> items);
  void onLoadNewsError();
}

class NewsListPresenter {
  NewsListViewContract _view;
  NewsRepository _repository;

  NewsListPresenter(this._view) {
    _repository = new Injector().newsRepository;
  }

  void loadNews() {
    _repository.fetchNews()
        .then((c) => _view.onLoadNewsComplete(c))
        .catchError((onError) => _view.onLoadNewsError());
  }
}
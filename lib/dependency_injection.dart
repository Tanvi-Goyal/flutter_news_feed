import 'data/news_data.dart';
import 'data/news_mock.dart';
import 'data/news_prod.dart';

enum Flavour {
  MOCK,PROD
}

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavour _flavour;

  static void configure(Flavour flavour) {
    _flavour = flavour;
  }

  factory Injector(){
    return _singleton;
  }

  Injector._internal();

  NewsRepository get newsRepository{

    switch(_flavour) {
      case Flavour.MOCK : return new MocknewsRepository();
      default: return new ProdNewsRepository();
    }
  }
}
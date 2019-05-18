import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'data/news_data.dart';

// database table and column names
final String tableNews = 'news';

// singleton class to manage the database
class DatabaseHelper {
  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";

  // Increment this version when you need to change the schema.
  static final _databaseVersion = 2;

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    await db.execute(
        """CREATE TABLE `news` ( `title` TEXT NOT NULL PRIMARY KEY, `author` TEXT NOT NULL ,
     `description` TEXT NOT NULL , `url` TEXT NOT NULL , `urlToImage` TEXT NOT NULL , `publishedAt` TEXT NOT NULL )""");
  }

  // Database helper methods:

  Future<int> insert(News news) async {
    Database db = await database;
    int title = (await db.insert(tableNews, news.toMap()));
    print("Title is " + title.toString());
    return title;
  }

  Future<List<Map<String, dynamic>>> queryNews() async {
    Database db = await database;
    List<Map<String, dynamic>> records = await db.query(tableNews);
    return records;
  }

  Future<int> delete() async {
    var dbClient = await database;
    int res = await dbClient.delete("news");
    return res;
  }

// TODO: queryAllWords()
// TODO: delete(int id)
// TODO: update(Word word)
}

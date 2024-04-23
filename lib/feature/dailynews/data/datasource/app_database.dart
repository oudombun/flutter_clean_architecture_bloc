import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/feature/dailynews/data/models/article.dart';
import 'local/DAO/article_dao.dart';
import 'package:sqflite/sqlite_api.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase{
  Dao get dao;
}

import 'package:floor/floor.dart';
import 'package:news_app_clean_architecture/feature/dailynews/data/models/article.dart';

@dao
abstract class Dao{
  @Insert()
  Future<void> insertArticle(ArticleModel articleModel);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);

  @Query("SELECT * FROM article")
  Future<List<ArticleModel>> getArticles();
}
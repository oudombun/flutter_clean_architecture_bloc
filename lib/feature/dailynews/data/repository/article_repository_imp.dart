import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/feature/dailynews/data/datasource/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/feature/dailynews/data/models/article.dart';
import 'package:news_app_clean_architecture/feature/dailynews/domain/entities/article.dart';
import 'package:news_app_clean_architecture/feature/dailynews/domain/repository/article_repository.dart';

import '../../../../core/constants/constants.dart';
import '../datasource/app_database.dart';

class ArticleRepositoryImp implements ArticleRepository{
  NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticleRepositoryImp(this._newsApiService,this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async{
    try{
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );
      if(httpResponse.response.statusCode==HttpStatus.ok){
        return DataSuccess(httpResponse.data);
      }else{
        print("hellod");

        return DataFailed(
            DioError(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioErrorType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            )
        );
      }
    } on DioError catch(e){
      print("hello");
      print(e.message);
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.dao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.dao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.dao.insertArticle(ArticleModel.fromEntity(article));
  }

}
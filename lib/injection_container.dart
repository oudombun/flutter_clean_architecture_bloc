import 'package:dio/dio.dart';
import 'package:floor/floor.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/feature/dailynews/data/datasource/app_database.dart';
import 'package:news_app_clean_architecture/feature/dailynews/data/repository/article_repository_imp.dart';

import 'feature/dailynews/data/datasource/remote/news_api_service.dart';
import 'feature/dailynews/domain/repository/article_repository.dart';
import 'feature/dailynews/domain/usecases/get_articles.dart';
import 'feature/dailynews/domain/usecases/get_saved_article.dart';
import 'feature/dailynews/domain/usecases/remove_article.dart';
import 'feature/dailynews/domain/usecases/save_article.dart';
import 'feature/dailynews/presentation/bloc/article/local/local_article_bloc.dart';
import 'feature/dailynews/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;


Future<void> initializeDependency() async{
  final database = await $FloorAppDatabase.databaseBuilder("app_database.db").build();
  sl.registerSingleton<AppDatabase>(database);
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(
      ArticleRepositoryImp(sl(),sl())
  );

  //UseCases
  sl.registerSingleton<GetArticleUseCase>(
      GetArticleUseCase(sl())
  );

  sl.registerSingleton<GetSavedArticleUseCase>(
      GetSavedArticleUseCase(sl())
  );

  sl.registerSingleton<SaveArticleUseCase>(
      SaveArticleUseCase(sl())
  );

  sl.registerSingleton<RemoveArticleUseCase>(
      RemoveArticleUseCase(sl())
  );

  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(
          ()=> RemoteArticlesBloc(sl())
  );


  sl.registerFactory<LocalArticleBloc>(
          ()=> LocalArticleBloc(sl(),sl(),sl())
  );

}
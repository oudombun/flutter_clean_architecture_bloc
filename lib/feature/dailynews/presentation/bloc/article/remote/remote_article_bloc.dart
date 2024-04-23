import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/feature/dailynews/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_clean_architecture/feature/dailynews/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../../../core/resources/data_state.dart';
import '../../../../domain/usecases/get_articles.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent,RemoteArticleState> {

  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticleLoading()){
    on <GetArticles> (onGetArticles);
  }


  void onGetArticles(GetArticles event, Emitter < RemoteArticleState > emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
          RemoteArticleDone(dataState.data!)
      );
    }

    if (dataState is DataFailed) {
      emit(
          RemoteArticleError(dataState.error!)
      );
    }
  }

}
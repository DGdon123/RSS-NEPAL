import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/domain/entities/core/all_news_request_params.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/domain/usecases/news/get_all_news.dart';

part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  final GetAllNews? getAllNews;

  AllNewsCubit({required this.getAllNews}) : super(AllNewsInitial());

  int page = 1;

  void fetchAllNews() {
    if (state is AllNewsLoading) return;

    final currentState = state;

    var oldPosts = <AllNewsEntity>[];
    if (currentState is AllNewsLoaded) {
      oldPosts = currentState.allNews;
    }

    emit(AllNewsLoading(oldPosts, isFirstFetch: page == 1));
    getAllNews!(AllNewsRequestParams(page)).then((newNews) {
      page++;

      newNews.fold((l) => AllNewsError(l.appErrorType), (r) {
        final news = (state as AllNewsLoading).oldNews;
        news.addAll(r);
        emit(AllNewsLoaded(news));
      });
    });
  }
}

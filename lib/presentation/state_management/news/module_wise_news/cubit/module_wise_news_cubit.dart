import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/module_wise_news_params.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/domain/usecases/news/module_wise_news/get_module_wise_news.dart';

part 'module_wise_news_state.dart';

class ModuleWiseNewsCubit extends Cubit<ModuleWiseNewsState> {
  ModuleWiseNewsCubit(this.getAllNews) : super(Initial());
  final GetModuleWiseNews? getAllNews;

  int page = 1;
  void fetchNewsByModule(int id) {
    if (state is ModuleWiseNewsLoading) return;

    final currentState = state;

    var oldPosts = <AllNewsEntity>[];
    if (currentState is ModuleWiseNewsLoaded) {
      oldPosts = currentState.moduleWiseNews;
    }

    emit(ModuleWiseNewsLoading(oldPosts, isFirstFetch: page == 1));
    getAllNews!(ModuleWiseRequestParam(page, id)).then((newNews) {
      page++;

      newNews.fold((l) => ModuleWiseNewsError(l.appErrorType), (r) {
        final news = (state as ModuleWiseNewsLoading).oldNews;
        news.addAll(r);
        emit(ModuleWiseNewsLoaded(news));
      });
    });
  }
}

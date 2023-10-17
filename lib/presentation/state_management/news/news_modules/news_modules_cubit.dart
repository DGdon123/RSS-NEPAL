import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/entities/news/new_modules_entities.dart';
import 'package:rss/domain/usecases/news/get_news_modules.dart';

part 'news_modules_state.dart';

class NewsModulesCubit extends Cubit<NewsModulesState> {
  final GetNewsModules? getNewsModules;
  NewsModulesCubit({required this.getNewsModules}) : super(Initial());

  void fetchNewsModules() async {
    emit(NewsModulesLoading());
    final newsModulesEither = await getNewsModules!(NoParams());
    emit(
      newsModulesEither.fold(
        (l) => NewsModulesError(l.appErrorType),
        (r) => NewsModulesLoaded(r),
      ),
    );
  }
}

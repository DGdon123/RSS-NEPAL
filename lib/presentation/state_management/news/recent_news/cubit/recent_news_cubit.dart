import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/entities/news/recent_news_entities.dart';
import 'package:rss/domain/usecases/news/get_recent_news.dart';

part 'recent_news_state.dart';

class RecentNewsCubit extends Cubit<RecentNewsState> {
  final GetRecentNews? getRecentNews;
  RecentNewsCubit({required this.getRecentNews}) : super(RecentNewsInitial());

  void fetchRecentNews() async {
    emit(RecentNewsLoading());
    final recentNewsEither = await getRecentNews!(NoParams());
    emit(
      recentNewsEither.fold(
        (l) => RecentNewsError(l.appErrorType),
        (r) => RecentNewsLoaded(r),
      ),
    );
  }
}

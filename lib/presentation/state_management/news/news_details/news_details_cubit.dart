import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/data/model/news/news-details.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/news_details_request_params.dart';
import 'package:rss/domain/usecases/news/get_news_details.dart';

part 'news_details_state.dart';

class NewsDetailsCubit extends Cubit<NewsDetailsState> {
  final GetNewsDetails? getNewsDetails;

  NewsDetailsCubit({required this.getNewsDetails})
      : super(NewsDetailsInitial());

  void fetchNewsDetails(int? id) async {
    emit(NewsDetailsLoading());
    final recentNewsEither = await getNewsDetails!(
      NewsDetailsRequestParams(id),
    );
    emit(
      recentNewsEither.fold(
        (l) => NewsDetailsError(l.appErrorType),
        (r) => NewsDetailsLoaded(r),
      ),
    );
  }
}

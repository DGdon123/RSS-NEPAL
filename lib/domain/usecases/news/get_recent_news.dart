import 'package:rss/domain/entities/core/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/entities/news/recent_news_entities.dart';
import 'package:rss/domain/repo/news/recent_news_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';


class GetRecentNews extends Usecase<List<RecentNewsEntity>, NoParams>{
  final RecentNewsRepo repo;

  GetRecentNews(this.repo);

  @override
  Future<Either<AppError, List<RecentNewsEntity>>> call(NoParams params) async {
 
    return await repo.getRecentNews();
  }
}
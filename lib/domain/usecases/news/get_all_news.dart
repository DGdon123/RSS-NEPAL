import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/all_news_request_params.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/domain/repo/news/all_news_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetAllNews extends Usecase<List<AllNewsEntity>, AllNewsRequestParams> {
  final AllNewsRepo repo;

  GetAllNews(this.repo);

  @override
  Future<Either<AppError, List<AllNewsEntity>>> call(
      AllNewsRequestParams params) async {
    return await repo.getAllNews(params.page!);
  }
}

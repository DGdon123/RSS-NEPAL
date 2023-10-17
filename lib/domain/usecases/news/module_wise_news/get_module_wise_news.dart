import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/module_wise_news_params.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/domain/repo/news/module_wise_news_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetModuleWiseNews
    extends Usecase<List<AllNewsEntity>, ModuleWiseRequestParam> {
  final ModuleWiseNewsRepo repo;

  GetModuleWiseNews(this.repo);

  @override
  Future<Either<AppError, List<AllNewsEntity>>> call(
      ModuleWiseRequestParam params) async {
    return await repo.getNewsByModules(params.page!, params.id!);
  }
}

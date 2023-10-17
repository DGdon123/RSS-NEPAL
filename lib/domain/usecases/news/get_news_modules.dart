import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/entities/news/new_modules_entities.dart';
import 'package:rss/domain/repo/news/news_modules_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetNewsModules extends Usecase<List<NewsModuleEntity>, NoParams>{
  final NewsModulesRepo repo;

  GetNewsModules(this.repo);

  @override
  Future<Either<AppError, List<NewsModuleEntity>>> call(NoParams params) async {
 
    return await repo.getNewsModules();
  }
}
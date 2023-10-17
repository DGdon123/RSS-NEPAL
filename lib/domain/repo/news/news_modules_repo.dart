import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/news/new_modules_entities.dart';

abstract class NewsModulesRepo {
  Future<Either<AppError, List<NewsModuleEntity>>> getNewsModules();
}
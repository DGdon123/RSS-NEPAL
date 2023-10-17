import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';

abstract class ModuleWiseNewsRepo {
  Future<Either<AppError, List<AllNewsEntity>>> getNewsByModules(int p, int id);
}

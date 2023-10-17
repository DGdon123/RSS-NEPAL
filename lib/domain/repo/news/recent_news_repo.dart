import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/news/recent_news_entities.dart';

abstract class RecentNewsRepo {
  Future<Either<AppError, List<RecentNewsEntity>>> getRecentNews();
}
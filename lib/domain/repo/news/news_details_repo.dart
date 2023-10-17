import 'package:dartz/dartz.dart';
import 'package:rss/data/model/news/news-details.dart';
import 'package:rss/domain/entities/core/app_error.dart';

abstract class NewsDetailsRepo {
  Future<Either<AppError, Newdetailsmodel>> getNewsDetails(int p);
}

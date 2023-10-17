import 'package:dartz/dartz.dart';
import 'package:rss/data/model/news/news-details.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/news_details_request_params.dart';
import 'package:rss/domain/repo/news/news_details_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetNewsDetails
    extends Usecase<Newdetailsmodel, NewsDetailsRequestParams> {
  final NewsDetailsRepo repo;

  GetNewsDetails(this.repo);

  @override
  Future<Either<AppError, Newdetailsmodel>> call(
      NewsDetailsRequestParams params) async {
    return await repo.getNewsDetails(params.id!);
  }
}

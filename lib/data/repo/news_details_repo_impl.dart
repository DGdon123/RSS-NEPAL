import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/model/news/news-details.dart';
import 'package:rss/data/remote_data_source/news/news_details_data_source.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/news/news_details_repo.dart';

class NewsDeatilsRepoImpl extends NewsDetailsRepo {
  final NewsDetailsRemoteDataSource remoteDataSource;
  NewsDeatilsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, Newdetailsmodel>> getNewsDetails(id) async {
    try {
      final newsDetails = await remoteDataSource.getNewsDetails(id);
      return Right(newsDetails);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

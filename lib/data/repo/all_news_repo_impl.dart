import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/remote_data_source/news/all_news_remote_data_source.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/news/all_news_repo.dart';

class AllNewsRepoImpl extends AllNewsRepo {
  final AllNewsRemoteDataSource remoteDataSource;
  AllNewsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<AllNewsEntity>>> getAllNews(int p) async {
    try {
      final allNews = await remoteDataSource.getAllNews(p);
      return Right(allNews);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

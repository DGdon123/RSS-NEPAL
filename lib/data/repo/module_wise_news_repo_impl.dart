import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/remote_data_source/news/module_wise_news_remote_data_source.dart';
import 'package:rss/domain/entities/news/all_news_entities.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/news/module_wise_news_repo.dart';

class ModuleWiseNewsRepoImpl extends ModuleWiseNewsRepo {
  final ModuleWiseNewsRemoteDataSource remoteDataSource;
  ModuleWiseNewsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<AllNewsEntity>>> getNewsByModules(
      int p, int id) async {
    try {
      final allNews = await remoteDataSource.getNewsByModule(p, id);
      return Right(allNews);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

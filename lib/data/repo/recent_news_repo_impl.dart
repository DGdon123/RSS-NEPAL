import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/remote_data_source/news/recent_news_remote_data_source.dart';
import 'package:rss/domain/entities/news/recent_news_entities.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/news/recent_news_repo.dart';

class RecentNewsRepoImpl extends RecentNewsRepo {
  final RecentNewsRemoteDataSource remoteDataSource;
  RecentNewsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<RecentNewsEntity>>> getRecentNews() async{
     try {
       final recentNews = await remoteDataSource.getRecentNews();
       return Right(recentNews);
     } on SocketException{
       return Left(AppError(AppErrorType.network));
     } on Exception {
       return Left(AppError(AppErrorType.api));
     }
  }
  
}
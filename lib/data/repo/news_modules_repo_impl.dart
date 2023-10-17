
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/remote_data_source/news/news_modules_remote_data_source.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/news/new_modules_entities.dart';
import 'package:rss/domain/repo/news/news_modules_repo.dart';

class NewsModulesRepoImpl extends NewsModulesRepo {
  final NewModulesRemoteDataSource remoteDataSource;
  NewsModulesRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<NewsModuleEntity>>> getNewsModules() async{
     try {
       final newsModules = await remoteDataSource.getNewModules();
       return Right(newsModules);
     } on SocketException{
       return Left(AppError(AppErrorType.network));
     } on Exception {
       return Left(AppError(AppErrorType.api));
     }
  }
  
}
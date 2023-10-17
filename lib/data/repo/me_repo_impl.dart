import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/core/custom_exception.dart';
import 'package:rss/data/model/users/me_model.dart';
import 'package:rss/data/remote_data_source/user/me_remote_data_source.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/user/me_repo.dart';

class MeRepoImpl extends MeRepo {
  final MeRemoteDataSource remoteDataSource;
  MeRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, MeModel>> getMe() async {
    try {
      final recentNews = await remoteDataSource.getMe();
      return Right(recentNews);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on UnauthorizedException {
      return Left(AppError(AppErrorType.unauthroized));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

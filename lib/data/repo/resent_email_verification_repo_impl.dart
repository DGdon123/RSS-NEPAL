import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/model/email/resent_email_model.dart';
import 'package:rss/data/remote_data_source/email/resent_email_verification_remote_data_source.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/email/resend_email_verification_repo.dart';

class ResentEmailVerificationRepoImpl extends ResentEmailVerificationRepo {
  final ResentEmailVerificationRemoteDataSource remoteDataSource;
  ResentEmailVerificationRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, EmailModel>> resentEmailVerification() async {
    try {
      final recentNews = await remoteDataSource.resentEmailVerification();
      return Right(recentNews);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

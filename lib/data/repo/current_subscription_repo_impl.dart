import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rss/data/model/subscription/current_subscription.dart';
import 'package:rss/data/remote_data_source/subscriptions/current_subscription_data_source.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/repo/subscription/current_subscription_repo.dart';

class CurrentSubscriptionRepoImpl extends GetCurrentSubscriptionRepo {
  final CurrentSubscriptionDataSource remoteDataSource;
  CurrentSubscriptionRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, CurrenSubscription>> getCurrentSuibscription() async {
    try {
      final newsModules = await remoteDataSource.getCurrenttSubscription();
      return Right(newsModules);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

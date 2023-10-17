import 'dart:io';

import 'package:rss/data/remote_data_source/subscriptions/subscriptions_datasource.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:rss/domain/repo/subscription/request_subs_repo.dart';

class RequestSubsRepoImpl extends RequestSubsRepo {
  final SubscriptionDataSource? subscriptionDataSource;
  RequestSubsRepoImpl(this.subscriptionDataSource);
  @override
  Future<Either<AppError, String>> requestSubs(
      Map<String, dynamic> requestBody) async {
    try {
      final getSubsStatus =
          await subscriptionDataSource!.requestSubscription(requestBody);
      return Right(getSubsStatus!);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

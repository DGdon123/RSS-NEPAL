import 'package:dartz/dartz.dart';
import 'package:rss/data/model/subscription/current_subscription.dart';
import 'package:rss/domain/entities/core/app_error.dart';

abstract class GetCurrentSubscriptionRepo {
  Future<Either<AppError, CurrenSubscription>> getCurrentSuibscription();
}

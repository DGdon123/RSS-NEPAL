import 'package:dartz/dartz.dart';
import 'package:rss/data/model/subscription/current_subscription.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/repo/subscription/current_subscription_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetCurrentSubscription extends Usecase<CurrenSubscription, NoParams> {
  final GetCurrentSubscriptionRepo repo;
  GetCurrentSubscription(this.repo);
  @override
  Future<Either<AppError, CurrenSubscription>> call(NoParams params) async {
    return await repo.getCurrentSuibscription();
  }
}

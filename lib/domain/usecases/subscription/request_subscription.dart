import 'package:rss/domain/entities/core/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/subcription_request_params.dart';
import 'package:rss/domain/repo/subscription/request_subs_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class RequestSubcription extends Usecase<String, SubscriptionRequestParams> {
  final RequestSubsRepo repo;
  RequestSubcription(this.repo);
  @override
  Future<Either<AppError, String>> call(
      SubscriptionRequestParams params) async {
    return await repo.requestSubs(params.toJson());
  }
}

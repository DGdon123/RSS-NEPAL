import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';

abstract class RequestSubsRepo {
  Future<Either<AppError, String>> requestSubs(
      Map<String, dynamic> requestBody);
}

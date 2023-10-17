import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';

abstract class Usecase<Type, Params> {
  Future<Either<AppError, Type>> call(Params params);
}

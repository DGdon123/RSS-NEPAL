import 'package:dartz/dartz.dart';
import 'package:rss/data/model/users/me_model.dart';
import 'package:rss/domain/entities/core/app_error.dart';

abstract class MeRepo {
  Future<Either<AppError, MeModel>> getMe();
}

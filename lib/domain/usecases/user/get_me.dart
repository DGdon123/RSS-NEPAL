import 'package:dartz/dartz.dart';
import 'package:rss/data/model/users/me_model.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/repo/user/me_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetMe extends Usecase<MeModel, NoParams> {
  final MeRepo repo;

  GetMe(this.repo);

  @override
  Future<Either<AppError, MeModel>> call(NoParams params) async {
    return await repo.getMe();
  }
}

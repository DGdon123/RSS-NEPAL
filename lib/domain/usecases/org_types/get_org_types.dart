import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/entities/registration/org_type_entities.dart';
import 'package:rss/domain/repo/registration/org_type_rep.dart';
import 'package:rss/domain/usecases/usecases.dart';

class GetOrgTypes extends Usecase<List<OrgTypeEntity>, NoParams> {
  final OrgTypeRepo repo;

  GetOrgTypes(this.repo);

  @override
  Future<Either<AppError, List<OrgTypeEntity>>> call(NoParams params) async {
    return await repo.getOrgTypes();
  }
}

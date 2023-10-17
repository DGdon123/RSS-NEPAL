import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/registration/org_type_entities.dart';

abstract class OrgTypeRepo {
  Future<Either<AppError, List<OrgTypeEntity>>> getOrgTypes();
}

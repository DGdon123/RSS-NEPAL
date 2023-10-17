import 'dart:io';

import 'package:rss/data/remote_data_source/registration/org_type_remote_data_source.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:dartz/dartz.dart';
import 'package:rss/domain/entities/registration/org_type_entities.dart';
import 'package:rss/domain/repo/registration/org_type_rep.dart';

class OrgTypeRepoImpl extends OrgTypeRepo {
  final OrgTypeRemoteDataSource remoteDataSource;
  OrgTypeRepoImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<OrgTypeEntity>>> getOrgTypes() async {
    try {
      final orgTypes = await remoteDataSource.getOrgTypes();
      return Right(orgTypes);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}

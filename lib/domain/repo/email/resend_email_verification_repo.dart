import 'package:dartz/dartz.dart';
import 'package:rss/data/model/email/resent_email_model.dart';
import 'package:rss/domain/entities/core/app_error.dart';

abstract class ResentEmailVerificationRepo {
  Future<Either<AppError, EmailModel>> resentEmailVerification();
}

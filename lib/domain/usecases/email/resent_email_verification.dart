import 'package:dartz/dartz.dart';
import 'package:rss/data/model/email/resent_email_model.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/repo/email/resend_email_verification_repo.dart';
import 'package:rss/domain/usecases/usecases.dart';

class ResentEmailVerification extends Usecase<EmailModel, NoParams> {
  final ResentEmailVerificationRepo repo;

  ResentEmailVerification(this.repo);

  @override
  Future<Either<AppError, EmailModel>> call(NoParams noParams) async {
    return await repo.resentEmailVerification();
  }
}

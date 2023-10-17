import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/usecases/email/resent_email_verification.dart';

part 'resent_email_verification_state.dart';

class ResentEmailVerificationCubit extends Cubit<ResentEmailVerificationState> {
  ResentEmailVerification resentEmailVerification;
  ResentEmailVerificationCubit({required this.resentEmailVerification})
      : super(ResentEmailVerificationInitial());

  void resentVerficationMail() async {
    emit(LoadingState());
    final resentEither = await resentEmailVerification(NoParams());
    emit(
      resentEither.fold(
        (l) => ErrorState(l.appErrorType),
        (r) => EmailResentSuccessState(),
      ),
    );
  }
}

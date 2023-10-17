part of 'resent_email_verification_cubit.dart';

abstract class ResentEmailVerificationState extends Equatable {
  const ResentEmailVerificationState();
}

class ResentEmailVerificationInitial extends ResentEmailVerificationState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ResentEmailVerificationState {
  @override
  List<Object?> get props => [];
}

class EmailResentSuccessState extends ResentEmailVerificationState {
  final String message =
      "Email Verification sent successfully! Check Your email address.";
  @override
  List<Object?> get props => [message];
}

class ErrorState extends ResentEmailVerificationState {
  final AppErrorType message;
  ErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

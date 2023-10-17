import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final AppErrorType appErrorType;

  const AppError(this.appErrorType);

  @override
  List<Object?> get props => [appErrorType];
}

enum AppErrorType {
  unauthroized,
  api,
  network,
  databse,
  sessionDenied,
  not_subscribed,
  not_verified
}

part of 'me_cubit.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object> get props => [];
}

class MeInitial extends MeState {}

class MeLoading extends MeState {}

class MeLoaded extends MeState {
  final MeModel me;

  const MeLoaded(this.me);

  @override
  List<Object> get props => [me];
}

class MeError extends MeState {
  final AppErrorType errorType;

  const MeError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

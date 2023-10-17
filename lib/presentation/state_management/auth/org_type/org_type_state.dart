part of 'org_type_cubit.dart';

abstract class OrgTypeState extends Equatable {
  const OrgTypeState();

  @override
  List<Object> get props => [];
}

class Initial extends OrgTypeState {}

class OrgTypeLoading extends OrgTypeState {}

class OrgTypeLoaded extends OrgTypeState {
  final List<OrgTypeEntity> orgTypes;

  const OrgTypeLoaded(this.orgTypes);

  @override
  List<Object> get props => [orgTypes];
}

class OrgTypeError extends OrgTypeState {
  final AppErrorType errorType;

  const OrgTypeError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

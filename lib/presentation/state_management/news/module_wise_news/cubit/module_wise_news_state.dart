part of 'module_wise_news_cubit.dart';

abstract class ModuleWiseNewsState extends Equatable {
  const ModuleWiseNewsState();

  @override
  List<Object> get props => [];
}

class Initial extends ModuleWiseNewsState {}

class ModuleWiseNewsLoading extends ModuleWiseNewsState {
  final List<AllNewsEntity> oldNews;
  final bool isFirstFetch;

  ModuleWiseNewsLoading(this.oldNews, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldNews];
}

class ModuleWiseNewsLoaded extends ModuleWiseNewsState {
  final List<AllNewsEntity> moduleWiseNews;

  const ModuleWiseNewsLoaded(this.moduleWiseNews);

  @override
  List<Object> get props => [moduleWiseNews];
}

class ModuleWiseNewsError extends ModuleWiseNewsState {
  final AppErrorType errorType;

  const ModuleWiseNewsError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

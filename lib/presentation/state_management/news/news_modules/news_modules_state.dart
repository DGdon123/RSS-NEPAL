part of 'news_modules_cubit.dart';

abstract class NewsModulesState extends Equatable {
  const NewsModulesState();

  @override 
  List<Object> get props => [];
}

class Initial extends NewsModulesState{}

class NewsModulesLoading extends NewsModulesState {}

class NewsModulesLoaded extends NewsModulesState{
  final List<NewsModuleEntity> newsModules;

  const NewsModulesLoaded(this.newsModules);

  @override 
  List<Object> get props => [newsModules];
}

class NewsModulesError extends NewsModulesState{
  final AppErrorType errorType;

  const NewsModulesError(this.errorType);

    @override 
  List<Object> get props => [errorType];
}
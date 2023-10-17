part of 'recent_news_cubit.dart';

abstract class RecentNewsState extends Equatable {
  const RecentNewsState();

  @override 
  List<Object> get props => [];
}

class RecentNewsInitial extends RecentNewsState{}

class RecentNewsLoading extends RecentNewsState {}

class RecentNewsLoaded extends RecentNewsState{
  final List<RecentNewsEntity> recentNews;

  const RecentNewsLoaded(this.recentNews);

  @override 
  List<Object> get props => [recentNews];
}

class RecentNewsError extends RecentNewsState{
  final AppErrorType errorType;

  const RecentNewsError(this.errorType);

    @override 
  List<Object> get props => [errorType];
}
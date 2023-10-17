part of 'all_news_cubit.dart';

abstract class AllNewsState extends Equatable {
  const AllNewsState();

  @override
  List<Object> get props => [];
}

class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {
  final List<AllNewsEntity> oldNews;
  final bool isFirstFetch;

  AllNewsLoading(this.oldNews, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldNews];
}

class AllNewsLoaded extends AllNewsState {
  final List<AllNewsEntity> allNews;

  const AllNewsLoaded(this.allNews);

  @override
  List<Object> get props => [allNews];
}

class AllNewsError extends AllNewsState {
  final AppErrorType errorType;

  const AllNewsError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

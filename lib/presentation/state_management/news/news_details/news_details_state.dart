part of 'news_details_cubit.dart';

abstract class NewsDetailsState extends Equatable {
  const NewsDetailsState();

  @override
  List<Object> get props => [];
}

class NewsDetailsInitial extends NewsDetailsState {}

class NewsDetailsLoading extends NewsDetailsState {}

class NewsDetailsLoaded extends NewsDetailsState {
  final Newdetailsmodel newsDetails;

  const NewsDetailsLoaded(this.newsDetails);

  @override
  List<Object> get props => [newsDetails];
}

class NewsDetailsError extends NewsDetailsState {
  final AppErrorType errorType;

  const NewsDetailsError(this.errorType);

  @override
  List<Object> get props => [errorType];
}

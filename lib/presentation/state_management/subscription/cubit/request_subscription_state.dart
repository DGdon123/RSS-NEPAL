part of 'request_subscription_cubit.dart';

abstract class RequestSubscriptionState extends Equatable {
  const RequestSubscriptionState();
}

class RequestSubscriptionInitial extends RequestSubscriptionState {
  @override
  List<Object> get props => [];
}

class LoadingState extends RequestSubscriptionState {
  @override
  List<Object?> get props => [];
}

class RequestSubscriptionSuccessState extends RequestSubscriptionState {
  final String message;

  RequestSubscriptionSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class ErrorState extends RequestSubscriptionState {
  final String message;
  ErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

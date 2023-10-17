part of 'current_subscription_cubit.dart';

abstract class CurrentSubscriptionState extends Equatable {}

class CurrentSubscriptionInitial extends CurrentSubscriptionState {
  @override
  List<Object> get props => [];
}

class CurrentSubscriptionLoadingState extends CurrentSubscriptionState {
  @override
  List<Object?> get props => [];
}

class CurrentSubscriptionSuccessState extends CurrentSubscriptionState {
  final CurrenSubscription message;

  CurrentSubscriptionSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class CurrentSubscriptionErrorState extends CurrentSubscriptionState {
  final String message;
  CurrentSubscriptionErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

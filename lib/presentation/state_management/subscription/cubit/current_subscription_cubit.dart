import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/data/model/subscription/current_subscription.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/usecases/subscription/get_current_subscription.dart';

part 'current_subscription_state.dart';

class CurrentSubscriptionCubit extends Cubit<CurrentSubscriptionState> {
  GetCurrentSubscription getCurrentSubscription;
  CurrentSubscriptionCubit({required this.getCurrentSubscription})
      : super(CurrentSubscriptionInitial());

  void fetchCurrentSubscription() async {
    emit(CurrentSubscriptionLoadingState());
    final currentSubscriptionEither = await getCurrentSubscription(NoParams());
    emit(
      currentSubscriptionEither.fold(
        (l) => CurrentSubscriptionErrorState(l.appErrorType.toString()),
        (r) => CurrentSubscriptionSuccessState(r),
      ),
    );
  }
}

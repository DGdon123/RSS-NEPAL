import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/domain/entities/core/subcription_request_params.dart';
import 'package:rss/domain/usecases/subscription/request_subscription.dart';

part 'request_subscription_state.dart';

class RequestSubscriptionCubit extends Cubit<RequestSubscriptionState> {
  final RequestSubcription requestSubcription;
  RequestSubscriptionCubit({required this.requestSubcription})
      : super(RequestSubscriptionInitial());

  void reqSubs(String remarks) async {
    emit(LoadingState());
    final reqSubsEither =
        await requestSubcription(SubscriptionRequestParams(remarks: remarks));
    emit(reqSubsEither.fold((l) => ErrorState(l.appErrorType.toString()),
        (r) => RequestSubscriptionSuccessState(r)));
  }
}

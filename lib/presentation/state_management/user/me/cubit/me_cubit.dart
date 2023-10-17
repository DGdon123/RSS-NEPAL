import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/data/model/users/me_model.dart';
import 'package:rss/domain/entities/core/app_error.dart';
import 'package:rss/domain/entities/core/no_params.dart';
import 'package:rss/domain/usecases/user/get_me.dart';

part 'me_state.dart';

class MeCubit extends Cubit<MeState> {
  final GetMe? getMe;
  MeCubit(this.getMe) : super(MeInitial());

  void fetchMe() async {
    emit(MeLoading());
          final meEither = await getMe!(NoParams());
              emit(
        meEither.fold(
          (l) => MeError(l.appErrorType),
          (r) => MeLoaded(r),
        ),
      );
    // await Future.delayed(const Duration(seconds: 2), () async {
    //   // final meEither = await getMe!(NoParams());
    //   // emit(
    //   //   meEither.fold(
    //   //     (l) => MeError(l.appErrorType),
    //   //     (r) => MeLoaded(r),
    //   //   ),
    //   // );
    // });
  }
}

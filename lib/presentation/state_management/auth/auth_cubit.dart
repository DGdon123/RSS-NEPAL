import 'package:auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/data/cache/auth/auth_local_store_contract.dart';
import 'package:rss/presentation/state_management/auth/auth_state.dart';
import 'package:async/async.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthLocalStore? authLocalStore;

  AuthCubit(this.authLocalStore) : super(InitialState());

  signIn(IAuthService authService, AuthType type) async {
    emit(LoadingState());
    final result = await authService.signIn();
    await authLocalStore!.saveAuthType(type);
    _setResultOfAuthState(result!);
  }

  // signUp(IAuthService authService, AuthType type) async {
  //   emit(LoadingState());
  //   final result = await authService.signUp();
  //   await authLocalStore!.saveAuthType(type);
  //   _setResultOfAuthState(result!);
  // }
  signUp(IAuthService authService, AuthType type) async {
    emit(LoadingState());
    var retult = await authService.signUp();
    _setResultOfSignUpState(retult!);
  }

  void _setResultOfAuthState(Result<Token> result) {
    if (result.asError != null) {
      // emit(ErrorState(result.asError!.error.toString()));
      emit(ErrorState());
    } else {
      authLocalStore!.save(result.asValue!.value);
      emit(AuthSuccessState(result.asValue!.value));
    }
  }

  void _setResultOfSignUpState(Result<Token> result) {
    if (result.asError != null) {
      emit(ErrorState());
    } else {
      authLocalStore!.save(result.asValue!.value);
      emit(SignUpSuccessState());
    }
  }
}

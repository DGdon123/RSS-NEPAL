import 'package:auth/auth.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessState extends AuthState {
  final Token token;
  AuthSuccessState(this.token);
  @override
  List<Object?> get props => [token];
}

class ErrorState extends AuthState {
  final String message = "The email has already been taken";
  @override
  List<Object?> get props => [message];
}

class SignUpSuccessState extends AuthState {
  final String message = "Sign Up Success! Check your email for verification!";
  @override
  List<Object?> get props => [message];
}

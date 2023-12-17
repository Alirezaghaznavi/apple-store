part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthResponseState extends AuthState {
  Either<String, String> response;
  AuthResponseState(this.response);
}

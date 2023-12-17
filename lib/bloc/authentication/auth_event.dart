part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLogingRequest extends AuthEvent {
  String username;
  String password;
  AuthLogingRequest(this.username, this.password);
}

import 'package:apple_store/data/repository/authentication-repository.dart';
import 'package:apple_store/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository = locatore.get();
  AuthBloc() : super(AuthInitialState()) {
    on<AuthLogingRequest>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _repository.login(event.username, event.password);
      emit(AuthResponseState(response));
    });
  }
}

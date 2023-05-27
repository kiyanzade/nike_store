import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/auth_repository.dart';

import '../../../data/repo/cart_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool isLoginMode;
  final IAuthRepository authRepository;
  final ICartRepository cartRepository;
  AuthBloc(this.authRepository, this.cartRepository, {this.isLoginMode = true})
      : super(AuthInitialState(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonIsClickedEvent) {
          emit(AuthLoadingState(isLoginMode));
          if (isLoginMode) {
            await authRepository.login(event.username, event.password);
             await cartRepository.count();
            emit(AuthSuccessState(isLoginMode));
          } else {
            await authRepository.signUp(event.username, event.password);
            emit(AuthSuccessState(isLoginMode));
          }
        } else if (event is AuthChangeModeEvent) {
          isLoginMode = !isLoginMode;
          emit(AuthInitialState(isLoginMode));
        }
      } catch (e) {
        emit(AuthErrorState(isLoginMode, AppException()));
      }
    });
  }
}

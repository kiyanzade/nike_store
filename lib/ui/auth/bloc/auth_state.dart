part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isLoginMode;
  const AuthState(this.isLoginMode);

  @override
  List<Object> get props => [isLoginMode];
}

class AuthInitialState extends AuthState {
  const AuthInitialState(bool isLoginMode) : super(isLoginMode);
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState(bool isLoginMode) : super(isLoginMode);
}

class AuthSuccessState extends AuthState {
  const AuthSuccessState(bool isLoginMode) : super(isLoginMode);
}

class AuthErrorState extends AuthState {
  final AppException appException;

  const AuthErrorState(bool isLoginMode, this.appException)
      : super(isLoginMode);
}

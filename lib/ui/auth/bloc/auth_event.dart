part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStartedEvent extends AuthEvent {
  const AuthStartedEvent() : super();
}

class AuthButtonIsClickedEvent extends AuthEvent {
  final String username;
  final String password;
  const AuthButtonIsClickedEvent(this.username, this.password) : super();
}

class AuthChangeModeEvent extends AuthEvent {
  const AuthChangeModeEvent() : super();
}

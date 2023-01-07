part of 'm_auth_bloc.dart';



abstract class AuthEvent extends Equatable {
  const AuthEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

class RegisterManagerEvent extends AuthEvent {
  final Map authData;

  RegisterManagerEvent(this.authData) : super([authData]);
}

class LoginManagerEvent extends AuthEvent {
  final Map authData;

  LoginManagerEvent(this.authData) : super([authData]);
}

class GetCurrentManagerEvent extends AuthEvent {}


class LogoutEvent extends AuthEvent {}

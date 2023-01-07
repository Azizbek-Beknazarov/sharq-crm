part of 'm_auth_bloc.dart';






abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class LoadedManagerState extends AuthState {
  final ManagerEntity managerEntity;

  const LoadedManagerState({required this.managerEntity});

  @override
  List<Object> get props => [managerEntity];
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageState extends AuthState {
  final String message;

  const MessageState({required this.message});

  @override
  List<Object> get props => [message];
}

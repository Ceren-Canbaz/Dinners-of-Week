part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadedState extends AuthState {
  final Auth auth;

  const AuthLoadedState({required this.auth});
  @override
  List<Object> get props => [auth];
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState({required this.error});
  List<Object> get props => [error];
}

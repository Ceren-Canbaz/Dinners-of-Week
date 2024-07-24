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

class SignInState extends AuthState {
  final TeamUser user;

  const SignInState({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthErrorState extends AuthState {
  final String error;

  const AuthErrorState({required this.error});
  List<Object> get props => [error];
}

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInInitialEvent extends AuthEvent {}

class SignUpInitialEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final Auth auth;

  const SignInEvent({required this.auth});
  @override
  List<Object> get props => [auth];
}

class SignUpEvent extends AuthEvent {
  final Auth auth;

  const SignUpEvent({required this.auth});
  @override
  List<Object> get props => [auth];
}

class SignUpErrorEvent extends AuthEvent {
  final String message;

  const SignUpErrorEvent({required this.message});
  @override
  List<Object> get props => [message];
}

class SignUpSuccessEvent extends AuthEvent {
  final Auth auth;

  const SignUpSuccessEvent({required this.auth});
  @override
  List<Object> get props => [auth];
}

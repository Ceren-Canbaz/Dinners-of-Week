part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInInitialEvent extends AuthEvent {}

class SignUpInitialEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final TeamUser user;

  const SignInEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class SignUpEvent extends AuthEvent {
  final TeamUser user;

  const SignUpEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class SignUpErrorEvent extends AuthEvent {
  final String message;

  const SignUpErrorEvent({required this.message});
  @override
  List<Object> get props => [message];
}

class SignUpSuccessEvent extends AuthEvent {
  final TeamUser user;

  const SignUpSuccessEvent({required this.user});
  @override
  List<Object> get props => [user];
}

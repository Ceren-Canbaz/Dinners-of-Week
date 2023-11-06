part of 'team_bloc.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {} //loading proccess

class TeamLoadedState extends TeamState {}

class TeamCreateLoadingState extends TeamState {}

class TeamCreatedState extends TeamState {
  final TeamModel team;
  final Auth user;
  TeamCreatedState({required this.team, required this.user});
  @override
  List<Object> get props => [team];
}

class TeamCreateErrorState extends TeamState {
  final String message;

  const TeamCreateErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

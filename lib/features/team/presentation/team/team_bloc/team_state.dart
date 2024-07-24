part of 'team_bloc.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {} //loading proccess

class TeamLoadedState extends TeamState {}

class TeamLoadingState extends TeamState {}

class TeamCreatedState extends TeamState {
  final TeamModel team;
  final TeamUser user;
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

class TeamJoinedState extends TeamState {
  final TeamModel team;
  final TeamUser user;

  TeamJoinedState({required this.team, required this.user});
}

class TeamJoinErrorState extends TeamState {
  final String message;

  TeamJoinErrorState({required this.message});
}

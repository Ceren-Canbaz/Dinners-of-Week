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

  TeamCreatedState({required this.team});
  @override
  List<Object> get props => [team];
}

class TeamCreateErrorState extends TeamState {
  final String message;

  const TeamCreateErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

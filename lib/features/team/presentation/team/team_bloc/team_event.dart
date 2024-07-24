part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamInitialEvent extends TeamEvent {}

class TeamCreateEvent extends TeamEvent {
  final String teamName;
  final TeamUser user;

  const TeamCreateEvent({required this.teamName, required this.user});
  @override
  List<Object> get props => [teamName, user];
}

class TeamJoinEvent extends TeamEvent {
  final String teamCode;
  final TeamUser user;

  TeamJoinEvent({required this.teamCode, required this.user});
  @override
  List<Object> get props => [teamCode, user];
}

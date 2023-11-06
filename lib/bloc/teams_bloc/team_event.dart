part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamInitialEvent extends TeamEvent {}

class TeamCreateEvent extends TeamEvent {
  final String teamName;
  final Auth user;

  const TeamCreateEvent({required this.teamName, required this.user});
  @override
  List<Object> get props => [teamName, user];
}

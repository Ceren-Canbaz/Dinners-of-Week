part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamInitialEvent extends TeamEvent {}

class TeamCreateEvent extends TeamEvent {
  final String teamName;

  const TeamCreateEvent({required this.teamName});
  @override
  List<Object> get props => [teamName];
}

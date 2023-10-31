part of 'team_bloc.dart';

abstract class TeamEvent extends Equatable {
  const TeamEvent();

  @override
  List<Object> get props => [];
}

class TeamInitialEvent extends TeamEvent {}

class TeamCreateEvent extends TeamEvent {
  final TeamModel team;

  const TeamCreateEvent({required this.team});
  @override
  List<Object> get props => [team];
}

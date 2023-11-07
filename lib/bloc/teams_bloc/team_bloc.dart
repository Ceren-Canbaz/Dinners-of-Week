import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/model/auth.dart';
import 'package:dinners_of_week/model/team.dart';
import 'package:dinners_of_week/repository/teams_repository.dart';
import 'package:equatable/equatable.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TeamsRepository teamsRepository;
  TeamBloc(this.teamsRepository) : super(TeamInitial()) {
    on<TeamEvent>((event, emit) {});
    on<TeamCreateEvent>(
      (event, emit) async {
        try {
          emit(TeamLoadingState());
          final team = await teamsRepository.createTeam(event.teamName);
          await teamsRepository.setCodeToUser(
            user: event.user,
            code: team.code,
          );

          emit(TeamCreatedState(
              team: team, user: event.user.copyWith(isAdmin: true)));
        } catch (e) {
          emit(const TeamCreateErrorState(message: "Something went wrong"));
        }
      },
    );
    on<TeamJoinEvent>(
      (event, emit) async {
        try {
          emit(TeamLoadedState());
          final team = await teamsRepository.joinTeam(
              teamCode: event.teamCode, user: event.user);
          emit(TeamJoinedState(team: team, user: event.user));
        } catch (e) {
          print("e $e");
          emit(TeamJoinErrorState(message: e.toString()));
        }
      },
    );
  }
}

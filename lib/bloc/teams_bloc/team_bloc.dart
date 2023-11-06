import 'package:bloc/bloc.dart';
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
          emit(TeamCreateLoadingState());
          final status = await teamsRepository.createTeam(event.teamName);
        } catch (e) {
          emit(const TeamCreateErrorState(message: "Something went wrong"));
        }
      },
    );
  }
}

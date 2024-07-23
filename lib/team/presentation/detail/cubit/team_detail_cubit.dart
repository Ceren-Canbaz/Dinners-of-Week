import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/team/domain/teams_repository.dart';
import 'package:equatable/equatable.dart';

part 'team_detail_state.dart';

class TeamDetailCubit extends Cubit<TeamDetailState> {
  final TeamsRepository _repo;
  TeamDetailCubit({required TeamsRepository repo})
      : _repo = repo,
        super(const TeamDetailState());
  Future<void> addFootToCalendar() async {
    await _repo.addFoodTeamCalendar(
      teamId: "0417f581-7e87-4a52-8546-bc9808082a6c",
      foodId: "50c6c1b8-b788-47c9-8633-e5aa39e37366",
      date: DateTime.now(),
    );
  }

  Future<void> getWeeklyFoodList({required String teamId}) async {
    await _repo.getWeeklyFoodList(teamId: teamId);
    // final response = await supabase
    //     .from('team_foods')
    //     .select('foods (name)')
    //     .eq('team_id', teamId)
    //     .execute();
  }
}

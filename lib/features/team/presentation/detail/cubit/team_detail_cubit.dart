import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/features/team/data/models/team_food_dto.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:equatable/equatable.dart';

part 'team_detail_state.dart';

class TeamDetailCubit extends Cubit<TeamDetailState> {
  final TeamsRepository _repo;
  final String _id;
  TeamDetailCubit({required TeamsRepository repo, required String id})
      : _repo = repo,
        _id = id,
        super(
          const TeamDetailState(
            foods: [],
            requestState: RequestState.initial,
          ),
        ) {
    getWeeklyFoodList(teamId: _id);
  }
  Future<void> addFootToCalendar() async {
    await _repo.addFoodTeamCalendar(
      teamId: "0417f581-7e87-4a52-8546-bc9808082a6c",
      foodId: "50c6c1b8-b788-47c9-8633-e5aa39e37366",
      date: DateTime.now(),
    );
  }

  Future<void> getWeeklyFoodList({required String teamId}) async {
    try {
      emit(
        state.copyWith(
          requestState: RequestState.loading,
        ),
      );
      final foods = await _repo.getWeeklyFoodList(teamId: teamId);
      emit(
        state.copyWith(
          requestState: RequestState.loaded,
          foods: foods,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          requestState: RequestState.error,
        ),
      );
    }
  }
}

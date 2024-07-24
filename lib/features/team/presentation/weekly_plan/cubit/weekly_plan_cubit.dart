import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/features/team/data/models/team_food_dto.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:equatable/equatable.dart';

part 'weekly_plan_state.dart';

class WeeklyPlanCubit extends Cubit<WeeklyPlanState> {
  final TeamsRepository _repo;
  final String _id;
  WeeklyPlanCubit({required TeamsRepository repo, required String id})
      : _repo = repo,
        _id = id,
        super(
          WeeklyPlanState(
              foods: [],
              requestState: RequestState.initial,
              selectedDate: DateTime.now(),
              weekDays: []),
        ) {
    _setWeekDays();
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

  void _setWeekDays() {
    final now = DateTime.now();
    final currentWeekday = now.weekday;
    final firstDayOfWeek = now.subtract(Duration(days: currentWeekday - 1));
    final weekdays =
        List.generate(5, (index) => firstDayOfWeek.add(Duration(days: index)));
    emit(
      state.copyWith(
        weekDays: weekdays,
      ),
    );
  }

  void setCurrentDay({required DateTime date}) {
    emit(
      state.copyWith(
        selectedDate: date,
      ),
    );
  }
}

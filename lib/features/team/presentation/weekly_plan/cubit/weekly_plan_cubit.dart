import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/team/data/models/team_food_dto.dart';
import 'package:dinners_of_week/features/team/domain/teams_repository.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:dinners_of_week/utils/extensions/date_extension.dart';
import 'package:equatable/equatable.dart';

part 'weekly_plan_state.dart';

class WeeklyPlanCubit extends Cubit<WeeklyPlanState> {
  final TeamsRepository _repo;
  final String _teamId;
  WeeklyPlanCubit({required TeamsRepository repo, required String id})
      : _repo = repo,
        _teamId = id,
        super(
          WeeklyPlanState(
            foods: [],
            requestState: RequestState.initial,
            selectedDate: DateTime.now(),
            weekDays: const [],
            selectedDaysFood: null,
          ),
        ) {
    _setWeekDays();
    getWeeklyFoodList(teamId: _teamId);
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

  Future<void> addFood({
    required Food food,
  }) async {
    try {
      await _repo.addFoodTeamCalendar(
        teamId: _teamId,
        foodId: food.id,
        date: state.selectedDate,
      );
      await getWeeklyFoodList(teamId: _teamId);
    } catch (e) {}
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
        selectedDate: now,
      ),
    );
  }

  void setCurrentDay({required DateTime date}) {
    TeamFoodDetails? selectedDaysFood;
    if (state.foods.isNotEmpty) {
      final food = state.foods.firstWhereOrNull(
        (element) => element.date.formattedDate() == date.formattedDate(),
      );

      if (food != null) {
        selectedDaysFood = food;
      }
    }
    emit(
        state.copyWith(selectedDate: date, selectedDaysFood: selectedDaysFood));
  }
}

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/team/data/models/team_food_detail.dart';
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
            selectedDaysFood: TeamFoodDetails.empty(),
          ),
        ) {
    _setWeekDays();
    getWeeklyFoodList(teamId: _teamId);
  }

  Future<void> getWeeklyFoodList({required String teamId}) async {
    TeamFoodDetails? selectedDaysFood;
    try {
      emit(
        state.copyWith(
          requestState: RequestState.loading,
        ),
      );
      final foods = await _repo.getWeeklyFoodList(teamId: teamId);
      if (foods.isNotEmpty) {
        final food = foods.firstWhereOrNull(
          (element) =>
              element.date.formattedDate() ==
              state.selectedDate.formattedDate(),
        );

        if (food != null) {
          selectedDaysFood = food;
        }
      }
      emit(
        state.copyWith(
          requestState: RequestState.loaded,
          foods: foods,
          selectedDaysFood: selectedDaysFood,
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
      await _repo.addFoodToCalendar(
        teamId: _teamId,
        foodId: food.id,
        date: state.selectedDate,
      );
      await getWeeklyFoodList(teamId: _teamId);
    } catch (e) {}
  }

  Future<void> edit({required String foodId}) async {
    try {
      emit(
        state.copyWith(
          requestState: RequestState.loading,
        ),
      );
      await _repo.editCalendar(id: state.selectedDaysFood.id, foodId: foodId);
      await getWeeklyFoodList(teamId: _teamId);
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
        selectedDate: now,
      ),
    );
  }

  Future<void> delete() async {
    try {
      await _repo.deleteFoodFromCalendar(id: state.selectedDaysFood.id);
      emit(
        state.copyWith(
          foods: state.foods
              .where((element) => element.id != state.selectedDaysFood.id)
              .toList(),
          selectedDaysFood: TeamFoodDetails.empty(),
        ),
      );
    } catch (e) {
      emit(state.copyWith());

      ///add modal state and show error modal;
    }
  }

  void setCurrentDay({required DateTime date}) {
    TeamFoodDetails? selectedDaysFood;
    if (state.foods.isNotEmpty) {
      final food = state.foods.firstWhereOrNull(
        (element) => element.date.formattedDate() == date.formattedDate(),
      );

      if (food != null) {
        selectedDaysFood = food;
      } else {
        selectedDaysFood = TeamFoodDetails.empty();
      }
    }
    emit(state.copyWith(
      selectedDate: date,
      selectedDaysFood: selectedDaysFood,
      requestState: RequestState.loaded,
    ));
  }
}

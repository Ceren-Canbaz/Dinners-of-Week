part of 'weekly_plan_cubit.dart';

class WeeklyPlanState extends Equatable {
  final List<TeamFoodDetails> foods;
  final RequestState requestState;
  final DateTime selectedDate;
  final List<DateTime> weekDays;
  final TeamFoodDetails? selectedDaysFood;

  const WeeklyPlanState({
    required this.foods,
    required this.requestState,
    required this.selectedDate,
    required this.weekDays,
    required this.selectedDaysFood,
  });

  @override
  List<Object> get props => [
        foods,
        requestState,
        weekDays,
        selectedDate,
      ];

  WeeklyPlanState copyWith(
      {List<TeamFoodDetails>? foods,
      RequestState? requestState,
      DateTime? selectedDate,
      List<DateTime>? weekDays,
      TeamFoodDetails? selectedDaysFood}) {
    return WeeklyPlanState(
        foods: foods ?? this.foods,
        requestState: requestState ?? this.requestState,
        selectedDate: selectedDate ?? this.selectedDate,
        weekDays: weekDays ?? this.weekDays,
        selectedDaysFood: selectedDaysFood);
  }
}

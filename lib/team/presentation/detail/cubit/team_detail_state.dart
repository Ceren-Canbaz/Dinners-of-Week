part of 'team_detail_cubit.dart';

class TeamDetailState extends Equatable {
  final List<TeamFoodDetails> foods;
  final RequestState requestState;

  const TeamDetailState({
    required this.foods,
    required this.requestState,
  });

  @override
  List<Object> get props => [
        foods,
        requestState,
      ];

  TeamDetailState copyWith({
    List<TeamFoodDetails>? foods,
    RequestState? requestState,
  }) {
    return TeamDetailState(
      foods: foods ?? this.foods,
      requestState: requestState ?? this.requestState,
    );
  }
}

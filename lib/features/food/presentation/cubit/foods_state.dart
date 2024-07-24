part of 'foods_cubit.dart';

class FoodsState extends Equatable {
  final List<Food> foods;
  final RequestState requestState;
  const FoodsState({
    required this.foods,
    required this.requestState,
  });

  @override
  List<Object> get props => [foods];

  FoodsState copyWith({
    List<Food>? foods,
    RequestState? requestState,
  }) {
    return FoodsState(
      foods: foods ?? this.foods,
      requestState: requestState ?? this.requestState,
    );
  }
}

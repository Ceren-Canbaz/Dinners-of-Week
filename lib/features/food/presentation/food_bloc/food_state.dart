part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

//initial
class FoodInitial extends FoodState {
  @override
  List<Object> get props => [];
}

class FoodLoadedState extends FoodState {
  final List<Food> foodList;

  const FoodLoadedState(this.foodList);
  @override
  List<Object> get props => [foodList];
}

class FoodLoadingErrorState extends FoodState {
  final String error;

  FoodLoadingErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class addFoodErrorState extends FoodState {
  final String error;

  addFoodErrorState(this.error);
  List<Object> get props => [error];
}

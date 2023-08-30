part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class LoadFoodEvent extends FoodEvent {}

class AddFoodEvent extends FoodEvent {
  final Food newFood;

  const AddFoodEvent(this.newFood);

  @override
  List<Object> get props => [newFood];
}

class DeleteFoodEvent extends FoodEvent {
  final Food food;

  DeleteFoodEvent(this.food);
  List<Object> get props => [food];
}

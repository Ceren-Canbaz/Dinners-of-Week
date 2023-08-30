import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_list/model/meal.dart';
import 'package:user_list/repository/food_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;
  FoodBloc(this.foodRepository) : super(FoodInitial()) {
    on<FoodEvent>(
      (event, emit) async {
        try {
          final foodList = await foodRepository.getFoods();
          emit(FoodLoadedState(foodList));
        } catch (e) {
          emit(FoodLoadingErrorState(e.toString()));
        }
      },
    );
    on<AddFoodEvent>(
      (event, emit) async {
        try {
          foodRepository.addFood(food: event.newFood);
          final updatedFoodList =
              await foodRepository.getFoods(); // Güncel yemek listesini al
          emit(FoodLoadedState(updatedFoodList));
        } catch (e) {
          emit(addFoodErrorState(e.toString()));
        }
      },
    );
    on<DeleteFoodEvent>(
      (event, emit) async {
        try {
          foodRepository.deleteFood(food: event.food);
          final updatedFoodList =
              await foodRepository.getFoods(); // Güncel yemek listesini al
          emit(FoodLoadedState(updatedFoodList));
        } catch (e) {
          emit(addFoodErrorState("Silemezsin"));
        }
      },
    );
  }
}

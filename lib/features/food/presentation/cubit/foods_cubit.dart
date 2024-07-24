import 'package:bloc/bloc.dart';
import 'package:dinners_of_week/features/food/data/models/food.dart';
import 'package:dinners_of_week/features/food/domain/food_repository.dart';
import 'package:dinners_of_week/utils/enums/request_state.dart';
import 'package:equatable/equatable.dart';

part 'foods_state.dart';

class FoodsCubit extends Cubit<FoodsState> {
  final FoodRepository _repo;
  FoodsCubit({required FoodRepository repo})
      : _repo = repo,
        super(const FoodsState(
          foods: [],
          requestState: RequestState.initial,
        ));

  Future<void> getFoods() async {
    try {
      emit(
        state.copyWith(
          requestState: RequestState.initial,
        ),
      );
      final result = await _repo.getFoods();
      emit(state.copyWith(foods: result, requestState: RequestState.loaded));
    } catch (e) {
      emit(state.copyWith(requestState: RequestState.error));
    }
  }
}

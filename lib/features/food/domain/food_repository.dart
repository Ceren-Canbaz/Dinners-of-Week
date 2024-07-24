import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/features/food/data/models/food.dart';

class FoodRepository {
  Future<List<Food>> getFoods() async {
    final response = await supabase.from('foods').select() as List;

    final foodList = response.map((e) => Food.fromMap(e)).toList();
    return foodList;
  }
}

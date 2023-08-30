import 'dart:convert';

import 'package:dinners_of_week/main.dart';
import 'package:dinners_of_week/model/meal.dart';

class FoodRepository {
  Future<List<Food>> getFoods() async {
    final response = await supabase.from('foods').select() as List;

    final foodList = response.map((e) => Food.fromMap(e)).toList();
    return foodList;
  }

  Food getFood({required int id}) {
    return Food(
        id: "123131",
        name: "Borulce",
        hasDrink: false,
        description: "borlucetest");
  }

  void addFood({required Food food}) async {
    await supabase.from("foods").insert(food.toJson());
  }

  void deleteFood({required Food food}) async {
    ///calismiyor
    await supabase.from("foods").delete().eq("id", food.id);

    // foodList.remove(food);
  }
}

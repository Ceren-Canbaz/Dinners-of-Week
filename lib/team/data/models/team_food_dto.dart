import 'package:equatable/equatable.dart';

class TeamFoodDetails extends Equatable {
  final int teamId;
  final int foodId;
  final String foodName;
  final String foodDescription;
  final bool hasDrink;
  final DateTime date;

  const TeamFoodDetails({
    required this.teamId,
    required this.foodId,
    required this.foodName,
    required this.foodDescription,
    required this.hasDrink,
    required this.date,
  });

  factory TeamFoodDetails.fromMap(Map<String, dynamic> map) {
    return TeamFoodDetails(
      teamId: map['teamId'],
      foodId: map['food_id'],
      date: map["food_date"],
      foodName: map['food_name'],
      foodDescription: map['food_description'],
      hasDrink: map['food_hasDrink'],
    );
  }

  @override
  List<Object?> get props => [
        teamId,
        foodId,
        date,
        foodName,
        foodDescription,
        hasDrink,
      ];
}

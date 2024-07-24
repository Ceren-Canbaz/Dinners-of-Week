import 'package:equatable/equatable.dart';

class TeamFoodDetails extends Equatable {
  final String teamId;
  final String foodId;
  final String foodName;
  final String foodDescription;
  final bool hasDrink;
  final DateTime date;
  final String imageUrl;

  const TeamFoodDetails(
      {required this.teamId,
      required this.foodId,
      required this.foodName,
      required this.foodDescription,
      required this.hasDrink,
      required this.date,
      required this.imageUrl});

  factory TeamFoodDetails.fromMap(Map<String, dynamic> map) {
    return TeamFoodDetails(
        teamId: map['teamId'],
        foodId: map['food_id'],
        date: DateTime.parse(map['food_date']),
        foodName: map['food_name'],
        foodDescription: map['food_description'],
        hasDrink: map['food_hasdrink'],
        imageUrl: map['food_imageurl']);
  }

  @override
  List<Object?> get props => [
        teamId,
        foodId,
        date,
        foodName,
        foodDescription,
        hasDrink,
        imageUrl,
      ];
}

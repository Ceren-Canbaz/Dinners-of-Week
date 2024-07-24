import 'package:equatable/equatable.dart';

class TeamFoodDetails extends Equatable {
  final String id;
  final String teamId;
  final String foodId;
  final String foodName;
  final String foodDescription;
  final bool hasDrink;
  final DateTime date;
  final String imageUrl;

  const TeamFoodDetails({
    required this.teamId,
    required this.foodId,
    required this.foodName,
    required this.foodDescription,
    required this.hasDrink,
    required this.date,
    required this.imageUrl,
    required this.id,
  });

  factory TeamFoodDetails.fromMap(Map<String, dynamic> map) {
    return TeamFoodDetails(
        id: map['id'],
        teamId: map['teamId'],
        foodId: map['food_id'],
        date: DateTime.parse(map['food_date']),
        foodName: map['food_name'],
        foodDescription: map['food_description'],
        hasDrink: map['food_hasdrink'],
        imageUrl: map['food_imageurl']);
  }
  factory TeamFoodDetails.empty() => TeamFoodDetails(
      teamId: "",
      foodId: "",
      foodName: "",
      foodDescription: "",
      hasDrink: false,
      date: DateTime.now(),
      imageUrl: "",
      id: "");

  @override
  List<Object?> get props => [
        teamId,
        foodId,
        date,
        id,
        foodName,
        foodDescription,
        hasDrink,
        imageUrl,
      ];
}

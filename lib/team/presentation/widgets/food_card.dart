import 'package:dinners_of_week/style/colors.dart';
import 'package:dinners_of_week/team/data/models/team_food_dto.dart';
import 'package:dinners_of_week/utils/extensions/date_extension.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.foods,
  });
  final List<TeamFoodDetails> foods;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ...foods.map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          e.date.formattedDateDay(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.ligtBlueColor,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          e.date.formattedDate(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.brownSugarColor,
                          ),
                        ),
                      ],
                    ),
                    Text(e.foodName),
                    Row(
                      children: [
                        Text(e.foodDescription),
                        const SizedBox(
                          width: 12,
                        ),
                        Icon(e.hasDrink ? Icons.local_bar : Icons.local_bar)
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

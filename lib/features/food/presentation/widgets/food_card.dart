import 'package:dinners_of_week/features/food/presentation/widgets/food_image_container.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String description;
  final bool hasDrink;
  final String imageUrl;

  const FoodCard(
      {super.key,
      required this.name,
      required this.description,
      required this.hasDrink,
      required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageContainer(imageUrl: imageUrl),
            const SizedBox(height: 8.0),
            Text(
              name, // Replace with e.name
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

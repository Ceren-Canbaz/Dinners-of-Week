import 'package:dinners_of_week/style/colors.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onDelete;
  final String title;

  const DeleteButton({super.key, required this.onDelete, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onDelete,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: const MaterialStatePropertyAll(
              AppColors.red,
            ),
          ),
      child: Text(
        title,
        style: buttonTextStyle(),
      ),
    );
  }
}

TextStyle buttonTextStyle() => const TextStyle(fontWeight: FontWeight.w400);

class Button extends StatelessWidget {
  const Button({super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: const MaterialStatePropertyAll(
              AppColors.darkGreen,
            ),
          ),
      child: child,
    );
  }
}

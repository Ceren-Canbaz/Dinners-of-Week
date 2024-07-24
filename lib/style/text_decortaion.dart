import 'dart:ui';

import 'package:dinners_of_week/style/colors.dart';
import 'package:flutter/material.dart';

TextStyle titleTextStyle({
  double fontSize = 20,
  Color color = AppColors.darkGreen,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
    shadows: [
      textShadow(),
    ],
  );
}

Shadow textShadow() {
  return Shadow(
      offset: const Offset(2.0, 2.0),
      blurRadius: 12,
      color: Colors.black.withOpacity(0.3));
}

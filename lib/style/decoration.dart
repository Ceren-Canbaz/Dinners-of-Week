import 'package:flutter/material.dart';

const Color red = Color(0xFFA30000);
const Color darkGreen = Color(0xFF477F90);
const Color beige = Color.fromARGB(255, 229, 219, 214);
const Color brown = Color(0xFFAF7060);

///// NEW COLORS
///
const Color eggshellColor = Color(0xFFFAFCF0);
const Color desertSandColor = Color(0xFFD6B39D);
const Color brownSugarColor = Color(0xFFB67561);
const Color ligtBlueColor = Color(0xFF427A93);
const Color grayColor = Color(0xFF365969);
const Color darkGrayColor = Color(0xFF304954);

// const String teamsText =
//     "Are you tired of the daily dilemma of what to have for lunch at work? We've got you covered! Food Team Tracker is the ultimate solution for companies and teams to streamline their lunchtime experience. With this innovative app, you can easily create your own team or join an existing one to manage and share your daily meal choices.";
InputDecoration textFieldDecoration(
    {required String hintText, required Color color}) {
  return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: color, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: color, width: 0.7),
      ));
}

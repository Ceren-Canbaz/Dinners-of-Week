import 'package:flutter/material.dart';

const Color red = Color(0xFFA30000);
const Color darkGreen = Color(0xFF477F90);
const Color beige = Color.fromARGB(255, 229, 219, 214);
const Color brown = Color(0xFFAF7060);
// const String teamsText =
//     "Are you tired of the daily dilemma of what to have for lunch at work? We've got you covered! Food Team Tracker is the ultimate solution for companies and teams to streamline their lunchtime experience. With this innovative app, you can easily create your own team or join an existing one to manage and share your daily meal choices.";
InputDecoration textFieldDecoration(
    {required String hintText, required Color color}) {
  return InputDecoration(
      hintText: hintText,
      fillColor: Colors.grey.shade200,
      filled: true,
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

import 'package:flutter/material.dart';

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

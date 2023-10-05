import 'package:flutter/material.dart';

const Color bgprimary = Color(0xFFA8C3C3);
const Color bgsecondary = Color(0xFFCEE1E2);
const Color titlecolor = Color(0xFF7dad94);
InputDecoration textFieldDecoration({required String hintText}) {
  return InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: bgprimary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: bgsecondary, width: 1.5),
      ));
}

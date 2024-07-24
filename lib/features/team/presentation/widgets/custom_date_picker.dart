import 'package:flutter/material.dart';

Future<void> selectDate(BuildContext context) async {
  DateTime? selectedDate;

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    selectableDayPredicate: (DateTime val) =>
        val.weekday >= DateTime.monday && val.weekday <= DateTime.friday,
  );
  if (pickedDate != null && pickedDate != selectedDate) {
    selectedDate = pickedDate;
  }
}

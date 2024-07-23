import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String formattedDateWithDay() {
    return DateFormat('EEEE dd.MM.yyyy').format(this);
  }

  String formattedDateDay() {
    return DateFormat('EEEE').format(this);
  }

  String formattedDate() {
    return DateFormat('dd.MM.yyyy').format(this);
  }
}

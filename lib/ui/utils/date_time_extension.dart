import 'package:intl/intl.dart';

extension TimeExtensions on DateTime {
  String get toFormattedDate {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }

  String get dayName {
    List<String> days = ["sat", "sun", "mon", "tue", "wed", "thurs", "fri"];
    return days[weekday - 1];
  }
}

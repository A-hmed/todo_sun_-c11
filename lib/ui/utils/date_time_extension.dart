import 'package:intl/intl.dart';

extension TimeExtensions on DateTime {
  String get toFormattedDate {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    return formatter.format(this);
  }
}

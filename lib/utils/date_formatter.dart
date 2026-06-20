import 'package:intl/intl.dart';

class AppDateFormatter {
  AppDateFormatter._();

  /// Example:
  /// 20 Jun 2026 • 6:42 PM
  static String formatExpenseDate(DateTime date) {
    return DateFormat(
      'dd MMM yyyy • h:mm a',
    ).format(date);
  }
}
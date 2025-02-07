import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateString(String dateString, String format) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat(format).format(dateTime);
  }
}
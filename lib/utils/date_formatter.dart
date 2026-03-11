import 'package:intl/intl.dart';

class DateFormatter {

  static String formatDate(DateTime date) {

    return DateFormat("yyyy-MM-dd").format(date);

  }

  static String formatDateTime(DateTime date) {

    return DateFormat("yyyy-MM-dd HH:mm").format(date);

  }

  static String formatReadable(DateTime date) {

    return DateFormat("MMM dd, yyyy").format(date);

  }

  static String formatTime(DateTime date) {

    return DateFormat("HH:mm").format(date);

  }

  static DateTime parseDate(String value) {

    return DateTime.parse(value);

  }

  static String today() {

    return formatDate(DateTime.now());

  }

  static bool isToday(DateTime date) {

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;

  }

  static int daysBetween(DateTime from, DateTime to) {

    return to.difference(from).inDays;

  }

  static String timeAgo(DateTime date) {

    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "just now";
    if (diff.inMinutes < 60) return "${diff.inMinutes} minutes ago";
    if (diff.inHours < 24) return "${diff.inHours} hours ago";
    if (diff.inDays < 7) return "${diff.inDays} days ago";

    return formatReadable(date);

  }

}
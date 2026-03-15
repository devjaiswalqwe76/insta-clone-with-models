class TimeFormatter {
  static String format(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inDays > 7) {
      return "${(duration.inDays / 7).floor()}w";
    } else if (duration.inDays > 0) {
      return "${duration.inDays}d";
    } else if (duration.inHours > 0) {
      return "${duration.inHours}h";
    } else if (duration.inMinutes > 0) {
      return "${duration.inMinutes}m";
    } else {
      return "now";
    }
  }
}

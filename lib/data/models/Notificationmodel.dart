enum NotificationType { ad, highlight, today, yesterday, lastWeek }

class InstaNotification {
  final String user;
  final String message;
  final NotificationType type;
  final String profileImageUrl;
  final String? postImageUrl;
  final String time;

  InstaNotification({
    required this.user,
    required this.message,
    required this.type,
    required this.profileImageUrl,
    this.postImageUrl,
    required this.time,
  });
}

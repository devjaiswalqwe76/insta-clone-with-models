import 'package:flutter/material.dart';
import '../data/models/Notificationmodel.dart';

class NotificationProvider extends ChangeNotifier {
  final List<InstaNotification> _items = [
    InstaNotification(
      user: "Sponsor",
      message: "Check out this new collection!",
      type: NotificationType.ad,
      profileImageUrl: "https://i.pravatar.cc/150?img=20",
      time: "Now",
    ),
    InstaNotification(
      user: "Highlight",
      message: "Check this out!",
      type: NotificationType.highlight,
      profileImageUrl: "https://i.pravatar.cc/150?img=21",
      time: "1h",
    ),
    InstaNotification(
      user: "kumar",
      message: "liked your photo.",
      type: NotificationType.today,
      profileImageUrl: "https://i.pravatar.cc/150?img=10",
      postImageUrl: "https://picsum.photos/id/101/200/200",
      time: "2h",
    ),
    InstaNotification(
      user: "karan",
      message: "started following you.",
      type: NotificationType.today,
      profileImageUrl: "https://i.pravatar.cc/150?img=11",
      time: "4h",
    ),
    InstaNotification(
      user: "rajan",
      message: "mentioned you in a comment: @demo_user check this out!",
      type: NotificationType.yesterday,
      profileImageUrl: "https://i.pravatar.cc/150?img=12",
      postImageUrl: "https://picsum.photos/id/102/200/200",
      time: "1d",
    ),
    InstaNotification(
      user: "dev",
      message: "liked your photo.",
      type: NotificationType.lastWeek,
      profileImageUrl: "https://i.pravatar.cc/150?img=13",
      postImageUrl: "https://picsum.photos/id/103/200/200",
      time: "5d",
    ),
  ];

  List<InstaNotification> get all => _items;
  
  List<InstaNotification> getByType(NotificationType type) => 
      _items.where((e) => e.type == type).toList();

  // Helper for grouping in the view
  Map<NotificationType, List<InstaNotification>> get grouped {
    Map<NotificationType, List<InstaNotification>> map = {};
    for (var item in _items) {
      if (!map.containsKey(item.type)) {
        map[item.type] = [];
      }
      map[item.type]!.add(item);
    }
    return map;
  }
}

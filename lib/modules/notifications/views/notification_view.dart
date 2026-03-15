import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/Notificationmodel.dart';
import '../../../providers/NotificationProvider.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          final grouped = provider.grouped;
          
          return ListView(
            children: [
              _buildSection("Today", grouped[NotificationType.today]),
              _buildSection("Yesterday", grouped[NotificationType.yesterday]),
              _buildSection("Last Week", grouped[NotificationType.lastWeek]),
              _buildSection("Suggested", grouped[NotificationType.ad]),
              _buildSection("Highlights", grouped[NotificationType.highlight]),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<InstaNotification>? notifications) {
    if (notifications == null || notifications.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ...notifications.map((n) => _NotificationTile(notification: n)),
        const Divider(height: 1, color: Colors.transparent),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final InstaNotification notification;

  const _NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(notification.profileImageUrl),
      ),
      title: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(
              text: "${notification.user} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: notification.message),
            TextSpan(
              text: " ${notification.time}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      trailing: notification.postImageUrl != null
          ? Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(notification.postImageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size(80, 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("Follow", style: TextStyle(fontSize: 12)),
            ),
    );
  }
}

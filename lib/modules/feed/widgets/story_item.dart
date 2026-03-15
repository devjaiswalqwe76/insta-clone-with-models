import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/models/story_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../controllers/feed_controller.dart';

class StoryItem extends StatelessWidget {
  final Story story;

  const StoryItem({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FeedController>().markStoryAsSeen(story.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Column(
          children: [
            // Reactive ring using Selector
            Selector<FeedController, bool>(
              selector: (_, controller) {
                final s = controller.stories.firstWhere((element) => element.id == story.id);
                return s.isSeen;
              },
              builder: (context, isSeen, child) {
                return Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isSeen
                        ? const LinearGradient(colors: [Colors.grey, Colors.grey])
                        : const LinearGradient(
                            colors: [
                              AppColors.storyGradientStart,
                              AppColors.storyGradientEnd,
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                  ),
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: CachedNetworkImageProvider(story.profileImage),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 70,
              child: Text(
                story.username,
                style: const TextStyle(fontSize: 11, color: Colors.black),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/post_model.dart';
import '../providers/feed_provider.dart';
import 'post_image_carousel.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// POST HEADER
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(post.profileImage),
          ),
          title: Text(
            post.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.more_vert),
        ),

        /// IMAGE
        GestureDetector(
          onDoubleTap: () {
            context.read<FeedProvider>().toggleLike(post.id);
          },
          child: PostImageCarousel(images: post.images),
        ),

        const SizedBox(height: 10),

        /// ACTIONS
        Row(
          children: [
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                context.read<FeedProvider>().toggleLike(post.id);
              },
              child: Icon(
                post.isLiked ? Icons.favorite : Icons.favorite_border,
                color: post.isLiked ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(width: 15),
            const Icon(Icons.chat_bubble_outline),
            const SizedBox(width: 15),
            const Icon(Icons.send),
            const Spacer(),
            GestureDetector(
              onTap: () {
                context.read<FeedProvider>().toggleSave(post.id);
              },
              child: Icon(
                post.isSaved ? Icons.bookmark : Icons.bookmark_border,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),

        const SizedBox(height: 8),

        /// LIKES
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "${post.likes} likes",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 4),

        /// CAPTION
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "${post.username} ${post.caption}",
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

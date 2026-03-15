import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/models/post_model.dart';
import '../controllers/feed_controller.dart';
import '../views/comment_view.dart';
import 'image_carousel.dart';
import 'like_button.dart';
import '../../../../core/constants/app_colors.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with SingleTickerProviderStateMixin {
  bool _showHeart = false;
  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _heartScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _heartController, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _onDoubleTap() {
    setState(() => _showHeart = true);
    context.read<FeedController>().toggleLike(widget.post.id);
    _heartController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) setState(() => _showHeart = false);
        _heartController.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// POST HEADER
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.storyGradientStart, AppColors.storyGradientEnd],
              ),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: CachedNetworkImageProvider(widget.post.profileImage),
              ),
            ),
          ),
          title: Text(
            widget.post.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          trailing: const Icon(Icons.more_vert),
        ),

        /// IMAGE CAROUSEL WITH DOUBLE TAP ANIMATION
        GestureDetector(
          onDoubleTap: _onDoubleTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImageCarousel(images: widget.post.images),
              if (_showHeart)
                ScaleTransition(
                  scale: _heartScale,
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
            ],
          ),
        ),

        /// ACTIONS
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              LikeButton(
                isLiked: widget.post.isLiked,
                onLikeChanged: (_) => context.read<FeedController>().toggleLike(widget.post.id),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommentView(post: widget.post)),
                ),
                child: const Icon(Icons.chat_bubble_outline, size: 26),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.send_outlined, size: 26),
              const Spacer(),
              GestureDetector(
                onTap: () => context.read<FeedController>().toggleSave(widget.post.id),
                child: Icon(
                  widget.post.isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 26,
                ),
              ),
            ],
          ),
        ),

        /// LIKES
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "${widget.post.likes} likes",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        /// CAPTION
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
              children: [
                TextSpan(
                  text: "${widget.post.username} ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: widget.post.caption),
              ],
            ),
          ),
        ),

        /// VIEW COMMENTS
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CommentView(post: widget.post)),
            ),
            child: Text(
              "View all comments",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}

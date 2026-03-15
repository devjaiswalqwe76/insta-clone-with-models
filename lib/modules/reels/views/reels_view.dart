import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/reels_controller.dart';
import '../../../data/models/reel_model.dart';

class ReelsView extends StatefulWidget {
  const ReelsView({super.key});

  @override
  State<ReelsView> createState() => _ReelsViewState();
}

class _ReelsViewState extends State<ReelsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReelsController>().loadReels();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reels",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined, color: Colors.white)),
        ],
      ),
      body: Consumer<ReelsController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.reels.length,
            itemBuilder: (context, index) {
              final reel = controller.reels[index];
              return _ReelItem(reel: reel);
            },
          );
        },
      ),
    );
  }
}

class _ReelItem extends StatelessWidget {
  final Reel reel;

  const _ReelItem({required this.reel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video Placeholder (Real video would use video_player package)
        Container(
          color: Colors.black,
          child: const Center(
            child: Icon(Icons.play_circle_outline, color: Colors.white54, size: 80),
          ),
        ),

        // Bottom Info & Controls
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: CachedNetworkImageProvider(reel.profileImage),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            reel.username,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => context.read<ReelsController>().toggleFollow(reel.id),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                reel.isFollowed ? "Following" : "Follow",
                                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        reel.caption,
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.music_note, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            reel.audioName,
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildActionButton(
                      context,
                      icon: reel.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: reel.isLiked ? Colors.red : Colors.white,
                      label: reel.likes.toString(),
                      onTap: () => context.read<ReelsController>().toggleLike(reel.id),
                    ),
                    _buildActionButton(
                      context,
                      icon: Icons.chat_bubble_outline,
                      label: reel.comments.toString(),
                      onTap: () {},
                    ),
                    _buildActionButton(
                      context,
                      icon: Icons.send_outlined,
                      label: "",
                      onTap: () {},
                    ),
                    _buildActionButton(
                      context,
                      icon: Icons.more_vert,
                      label: "",
                      onTap: () {},
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(imageUrl: reel.profileImage, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, Color color = Colors.white, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            if (label.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../controllers/feed_controller.dart';
import '../widgets/post_card.dart';
import '../widgets/story_item.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../notifications/views/notification_view.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Instagram",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26,
            fontFamily: 'InstagramSans',
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationView()),
              );
            },
            icon: const Icon(Icons.favorite_border, color: Colors.black, size: 28),
          ),
          // Removed the top chat_bubble icon as requested
        ],
      ),
      body: RefreshIndicator(
        color: Colors.black,
        onRefresh: () async {
          await HapticFeedback.mediumImpact();
          if (context.mounted) {
            await context.read<FeedController>().loadFeed();
          }
        },
        child: Selector<FeedController, bool>(
          selector: (_, controller) => controller.isLoading && controller.posts.isEmpty,
          builder: (context, isLoading, _) {
            if (isLoading) return const FeedShimmer();

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 400) {
                  context.read<FeedController>().loadMorePosts();
                }
                return true;
              },
              child: Selector<FeedController, int>(
                selector: (_, controller) => controller.posts.length,
                builder: (context, postsCount, _) {
                  if (postsCount == 0) {
                    return _buildEmptyState(context);
                  }

                  return ListView.builder(
                    cacheExtent: 1000,
                    itemCount: postsCount + 2,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const _ReactiveStoryList();
                      }

                      if (index == postsCount + 1) {
                        return const _ReactiveLoadMoreIndicator();
                      }

                      final postIndex = index - 1;
                      return PostCard(
                        key: ValueKey(context.read<FeedController>().posts[postIndex].id),
                        post: context.read<FeedController>().posts[postIndex],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No Posts Yet",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReactiveStoryList extends StatelessWidget {
  const _ReactiveStoryList();

  @override
  Widget build(BuildContext context) {
    return Selector<FeedController, int>(
      selector: (_, controller) => controller.stories.length,
      builder: (context, storiesCount, _) {
        if (storiesCount == 0) return const SizedBox.shrink();

        return Container(
          height: 120,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withAlpha(25),
                width: 1,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: storiesCount,
            itemBuilder: (context, index) {
              return StoryItem(
                story: context.read<FeedController>().stories[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _ReactiveLoadMoreIndicator extends StatelessWidget {
  const _ReactiveLoadMoreIndicator();

  @override
  Widget build(BuildContext context) {
    return Selector<FeedController, ({bool hasMore, bool isLoadingMore})>(
      selector: (_, controller) => (
        hasMore: controller.hasMore,
        isLoadingMore: controller.isLoadingMore,
      ),
      builder: (context, state, _) {
        if (!state.hasMore) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.grey, size: 32),
                  SizedBox(height: 8),
                  Text(
                    "You've caught up!",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "You've seen all new posts from the last 3 days.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          height: 100,
          child: Center(
            child: state.isLoadingMore
                ? const CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }
}

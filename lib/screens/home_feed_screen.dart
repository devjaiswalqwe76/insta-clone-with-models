import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feed_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/story_list.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FeedProvider>().loadFeed();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FeedProvider>().loadMorePosts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline, color: Colors.black),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<FeedProvider>().loadFeed(),
        child: Consumer<FeedProvider>(
          builder: (context, feed, child) {
            if (feed.isLoading && feed.posts.isEmpty) {
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            }

            return ListView.builder(
              controller: _scrollController,
              itemCount: feed.posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const StoryList();
                }

                final postIndex = index - 1;
                
                if (postIndex < feed.posts.length) {
                  return PostCard(post: feed.posts[postIndex]);
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: feed.hasMore
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text("No more posts", style: TextStyle(color: Colors.grey)),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

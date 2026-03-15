import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/story_model.dart';
import '../../../data/repositories/post_repository.dart';

class FeedController extends ChangeNotifier {
  final PostRepository _repository = PostRepository();

  List<Post> posts = [];
  List<Story> stories = [];
  
  bool isLoading = true;
  bool isLoadingMore = false;
  bool hasMore = true;
  int _currentPage = 1;
  static const int _limit = 5;

  Future<void> loadFeed() async {
    isLoading = true;
    _currentPage = 1;
    hasMore = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.fetchPosts(page: _currentPage, limit: _limit),
        _repository.fetchStories(),
      ]);

      posts = List<Post>.from(results[0]);
      stories = List<Story>.from(results[1]);
      
      if (posts.length < _limit) {
        hasMore = false;
      }
    } catch (e) {
      debugPrint("Error loading feed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMorePosts() async {
    if (isLoadingMore || !hasMore) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final newPosts = await _repository.fetchPosts(page: _currentPage, limit: _limit);

      if (newPosts.isEmpty) {
        hasMore = false;
      } else {
        if (newPosts.length < _limit) {
          hasMore = false;
        }
        posts.addAll(newPosts);
      }
    } catch (e) {
      _currentPage--;
      debugPrint("Error loading more posts: $e");
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  void toggleLike(String postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    posts[index].isLiked = !posts[index].isLiked;
    if (posts[index].isLiked) {
      posts[index].likes++;
    } else {
      posts[index].likes--;
    }
    notifyListeners();
  }

  void toggleSave(String postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    posts[index].isSaved = !posts[index].isSaved;
    notifyListeners();
  }

  void markStoryAsSeen(String storyId) {
    final index = stories.indexWhere((s) => s.id == storyId);
    if (index == -1 || stories[index].isSeen) return;

    stories[index].isSeen = true;
    notifyListeners();
  }
}

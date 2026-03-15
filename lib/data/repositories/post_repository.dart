import '../models/post_model.dart';
import '../models/story_model.dart';
import '../mock/mock_posts.dart';

class PostRepository {
  Future<List<Post>> fetchPosts({int page = 1, int limit = 5}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      final allPosts = MockData.posts;
      
      int startIndex = (page - 1) * limit;
      if (startIndex >= allPosts.length) return [];
      
      int endIndex = startIndex + limit;
      if (endIndex > allPosts.length) endIndex = allPosts.length;

      return allPosts.sublist(startIndex, endIndex);
    } catch (e) {
      return [];
    }
  }

  Future<List<Story>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.stories;
  }
}

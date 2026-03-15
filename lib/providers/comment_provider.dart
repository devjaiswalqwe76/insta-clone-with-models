import 'package:flutter/material.dart';
import '../data/models/comment_model.dart';

class CommentProvider extends ChangeNotifier {
  // Mock data stored in a map
  final Map<String, List<Comment>> _commentsMap = {};

  List<Comment> getCommentsForPost(String postId) {
    if (!_commentsMap.containsKey(postId)) {
      // Initialize with some mock comments for each post
      _commentsMap[postId] = [
        Comment(
          id: "c1",
          postId: postId,
          username: "Amrit",
          profileImage: "https://i.pravatar.cc/150?img=30",
          text: "Amazing shot!",
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          likes: 5,
        ),
        Comment(
          id: "c2",
          postId: postId,
          username: "pixel_art",
          profileImage: "https://i.pravatar.cc/150?img=31",
          text: "Which camera did you use?",
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          likes: 2,
        ),
      ];
    }
    return _commentsMap[postId]!;
  }

  void addComment(String postId, String text, String username, String profileImage) {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId,
      username: username,
      profileImage: profileImage,
      text: text,
      timestamp: DateTime.now(),
    );

    if (!_commentsMap.containsKey(postId)) {
      _commentsMap[postId] = [];
    }
    _commentsMap[postId]!.insert(0, newComment);
    notifyListeners();
  }

  void toggleCommentLike(String postId, String commentId) {
    final comments = _commentsMap[postId];
    if (comments == null) return;

    final index = comments.indexWhere((c) => c.id == commentId);
    if (index == -1) return;

    final comment = comments[index];
    comment.isLiked = !comment.isLiked;
    if (comment.isLiked) {
      comment.likes++;
    } else {
      comment.likes--;
    }
    notifyListeners();
  }
}

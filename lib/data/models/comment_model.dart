class Comment {
  final String id;
  final String postId;
  final String username;
  final String profileImage;
  final String text;
  final DateTime timestamp;
  int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.postId,
    required this.username,
    required this.profileImage,
    required this.text,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['postId'],
      username: json['username'],
      profileImage: json['profileImage'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
      likes: json['likes'] ?? 0,
      isLiked: json['isLiked'] ?? false,
    );
  }
}

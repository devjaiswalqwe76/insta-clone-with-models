class Post {
  final String id;
  final String username;
  final String profileImage;
  final String caption;
  final List<String> images;
  int likes;
  bool isLiked;
  bool isSaved;

  Post({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.caption,
    required this.images,
    required this.likes,
    required this.isLiked,
    required this.isSaved,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json["id"],
      username: json["username"],
      profileImage: json["profileImage"],
      caption: json["caption"],
      images: List<String>.from(json["images"]),
      likes: json["likes"],
      isLiked: json["isLiked"],
      isSaved: json["isSaved"],
    );
  }
}
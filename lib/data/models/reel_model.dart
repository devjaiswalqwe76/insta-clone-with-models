class Reel {
  final String id;
  final String username;
  final String profileImage;
  final String videoUrl;
  final String caption;
  final String audioName;
  int likes;
  int comments;
  bool isLiked;
  bool isFollowed;

  Reel({
    required this.id,
    required this.username,
    required this.profileImage,
    required this.videoUrl,
    required this.caption,
    required this.audioName,
    required this.likes,
    required this.comments,
    this.isLiked = false,
    this.isFollowed = false,
  });
}

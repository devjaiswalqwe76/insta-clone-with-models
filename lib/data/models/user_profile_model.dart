class UserProfile {
  final String username;
  final String fullName;
  final String bio;
  final String profileImage;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final List<String> posts;

  UserProfile({
    required this.username,
    required this.fullName,
    required this.bio,
    required this.profileImage,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    required this.posts,
  });
}

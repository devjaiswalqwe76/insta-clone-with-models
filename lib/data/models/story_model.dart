class Story {
  final String id;
  final String username;
  final String profileImage;
  bool isSeen;

  Story({
    required this.id,
    required this.username,
    required this.profileImage,
    this.isSeen = false,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json["id"],
      username: json["username"],
      profileImage: json["profileImage"],
      isSeen: json["isSeen"] ?? false,
    );
  }
}

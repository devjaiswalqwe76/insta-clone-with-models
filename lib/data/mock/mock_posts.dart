import '../models/post_model.dart';
import '../models/story_model.dart';

class MockData {
  static List<Post> get posts => [
    Post(
      id: "1",
      username: "flutter_dev",
      profileImage: "https://i.pravatar.cc/150?img=1",
      caption: "Building an Instagram clone with Flutter! 🚀 #flutter #dart #coding",
      images: [
        "https://picsum.photos/id/1/600/600",
        "https://picsum.photos/id/2/600/600",
      ],
      likes: 124,
      isLiked: false,
      isSaved: false,
    ),
    Post(
      id: "2",
      username: "travel_gram",
      profileImage: "https://i.pravatar.cc/150?img=2",
      caption: "A beautiful sunset in the mountains. 🏔️✨",
      images: [
        "https://picsum.photos/id/10/600/600",
      ],
      likes: 856,
      isLiked: true,
      isSaved: true,
    ),
    Post(
      id: "3",
      username: "foodie_vibes",
      profileImage: "https://i.pravatar.cc/150?img=3",
      caption: "The best pasta I've ever had! 🍝🇮🇹 #foodporn #pasta",
      images: [
        "https://picsum.photos/id/20/600/600",
        "https://picsum.photos/id/21/600/600",
        "https://picsum.photos/id/22/600/600",
      ],
      likes: 432,
      isLiked: false,
      isSaved: false,
    ),
  ];

  static List<Story> get stories => [
    Story(id: "1", username: "Your Story", profileImage: "https://i.pravatar.cc/150?img=10", isSeen: false),
    Story(id: "2", username: "alex_smith", profileImage: "https://i.pravatar.cc/150?img=11", isSeen: false),
    Story(id: "3", username: "sarah_j", profileImage: "https://i.pravatar.cc/150?img=12", isSeen: false),
    Story(id: "4", username: "tech_insider", profileImage: "https://i.pravatar.cc/150?img=13", isSeen: false),
    Story(id: "5", username: "wanderlust", profileImage: "https://i.pravatar.cc/150?img=14", isSeen: false),
    Story(id: "6", username: "design_daily", profileImage: "https://i.pravatar.cc/150?img=15", isSeen: false),
    Story(id: "7", username: "coffee_lover", profileImage: "https://i.pravatar.cc/150?img=16", isSeen: false),
  ];
}

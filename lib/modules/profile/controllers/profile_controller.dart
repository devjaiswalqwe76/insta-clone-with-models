import 'package:flutter/material.dart';
import '../../../data/models/user_profile_model.dart';

class ProfileController extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> loadUserProfile() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _userProfile = UserProfile(
      username: "demo_user",
      fullName: "Demo User",
      bio: "Flutter Developer | UI/UX Enthusiast | Tech Lover 🚀",
      profileImage: "https://i.pravatar.cc/150?img=50",
      postsCount: 12,
      followersCount: 1250,
      followingCount: 350,
      posts: List.generate(12, (index) => "https://picsum.photos/id/${index + 50}/300/300"),
    );

    _isLoading = false;
    notifyListeners();
  }
}

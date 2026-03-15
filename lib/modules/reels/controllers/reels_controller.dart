import 'package:flutter/material.dart';
import '../../../data/models/reel_model.dart';

class ReelsController extends ChangeNotifier {
  List<Reel> _reels = [];
  bool _isLoading = true;

  List<Reel> get reels => _reels;
  bool get isLoading => _isLoading;

  Future<void> loadReels() async {
    _isLoading = true;
    notifyListeners();

    // Mock data for Reels
    await Future.delayed(const Duration(seconds: 1));
    _reels = [
      Reel(
        id: "1",
        username: "nature_clips",
        profileImage: "https://i.pravatar.cc/150?img=35",
        videoUrl: "https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4",
        caption: "Beautiful nature #nature #flowers #spring",
        audioName: "Original Audio - nature_clips",
        likes: 12500,
        comments: 450,
      ),
      Reel(
        id: "2",
        username: "tech_reviews",
        profileImage: "https://i.pravatar.cc/150?img=36",
        videoUrl: "https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-946-large.mp4",
        caption: "New gadget unboxing! Check this out. #tech #unboxing",
        audioName: "Future Tech - Awesome Beats",
        likes: 8900,
        comments: 210,
      ),
      Reel(
        id: "3",
        username: "travel_vlogger",
        profileImage: "https://i.pravatar.cc/150?img=37",
        videoUrl: "https://assets.mixkit.co/videos/preview/mixkit-waves-in-the-ocean-1581-large.mp4",
        caption: "Miss the ocean vibes. 🌊 #travel #ocean #vacation",
        audioName: "Ocean Sounds - Travel Music",
        likes: 25400,
        comments: 1100,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void toggleLike(String reelId) {
    final index = _reels.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      _reels[index].isLiked = !_reels[index].isLiked;
      if (_reels[index].isLiked) {
        _reels[index].likes++;
      } else {
        _reels[index].likes--;
      }
      notifyListeners();
    }
  }

  void toggleFollow(String reelId) {
    final index = _reels.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      _reels[index].isFollowed = !_reels[index].isFollowed;
      notifyListeners();
    }
  }
}

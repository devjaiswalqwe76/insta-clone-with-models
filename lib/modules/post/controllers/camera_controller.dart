import 'package:flutter/material.dart';
import '../../../data/models/post_type_model.dart';

class PostCameraController extends ChangeNotifier {
  bool _isInitialized = false;
  PostType _selectedType = PostType.post;

  bool get isInitialized => _isInitialized;
  PostType get selectedType => _selectedType;

  // Mocking the camera controller and camera descriptions
  dynamic get controller => null;
  List<dynamic> get cameras => [];

  Future<void> initializeCamera() async {
    // Simulated delay for "initialization"
    await Future.delayed(const Duration(milliseconds: 500));
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> toggleCamera() async {
    // Mock toggle logic
    notifyListeners();
  }

  void setPostType(PostType type) {
    _selectedType = type;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

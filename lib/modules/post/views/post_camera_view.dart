import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/post_type_model.dart';
import '../controllers/camera_controller.dart';

class PostCameraView extends StatefulWidget {
  const PostCameraView({super.key});

  @override
  State<PostCameraView> createState() => _PostCameraViewState();
}

class _PostCameraViewState extends State<PostCameraView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostCameraController>().initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<PostCameraController>(
        builder: (context, controller, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Mock Camera Preview (Demo Mode)
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF1c1c1c), Colors.black],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_outlined, color: Colors.white24, size: 100),
                      const SizedBox(height: 20),
                      Text(
                        "Demo Camera Mode: ${controller.selectedType.name.toUpperCase()}",
                        style: const TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              // Gradient Overlays
              _buildGradientOverlay(top: true),
              _buildGradientOverlay(top: false),

              // Top Controls
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 10,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Icon(Icons.flash_off, color: Colors.white, size: 28),
                    const Icon(Icons.settings, color: Colors.white, size: 28),
                  ],
                ),
              ),

              // Side Tools
              const Positioned(
                left: 20,
                top: 150,
                child: Column(
                  children: [
                    Icon(Icons.text_fields, color: Colors.white, size: 28),
                    SizedBox(height: 25),
                    Icon(Icons.music_note, color: Colors.white, size: 28),
                    SizedBox(height: 25),
                    Icon(Icons.filter_vintage_outlined, color: Colors.white, size: 28),
                  ],
                ),
              ),

              // Bottom UI
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildModeSelector(controller),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildGalleryThumbnail(),
                          _buildShutterButton(),
                          _buildCameraFlip(controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGradientOverlay({required bool top}) {
    return Positioned(
      top: top ? 0 : null,
      bottom: top ? null : 0,
      left: 0,
      right: 0,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: top ? Alignment.topCenter : Alignment.bottomCenter,
            end: top ? Alignment.bottomCenter : Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeSelector(PostCameraController controller) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: PostType.values.length,
        padding: const EdgeInsets.symmetric(horizontal: 140),
        itemBuilder: (context, index) {
          final type = PostType.values[index];
          final isSelected = controller.selectedType == type;
          return GestureDetector(
            onTap: () => controller.setPostType(type),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                type.name.toUpperCase(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShutterButton() {
    return Container(
      height: 85,
      width: 85,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryThumbnail() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network("https://picsum.photos/100", fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildCameraFlip(PostCameraController controller) {
    return GestureDetector(
      onTap: () => controller.toggleCamera(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 28),
      ),
    );
  }
}

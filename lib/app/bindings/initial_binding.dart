import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../modules/feed/controllers/feed_controller.dart';
import '../../providers/NotificationProvider.dart';
import '../../providers/comment_provider.dart';
import '../../modules/profile/controllers/profile_controller.dart';
import '../../modules/search/controllers/search_controller.dart';
import '../../modules/post/controllers/camera_controller.dart';
import '../../modules/reels/controllers/reels_controller.dart';

class InitialBinding {
  static List<SingleChildWidget> dependencies = [
    ChangeNotifierProvider(create: (_) => FeedController()..loadFeed()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => CommentProvider()),
    ChangeNotifierProvider(create: (_) => ProfileController()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => PostCameraController()),
    ChangeNotifierProvider(create: (_) => ReelsController()),
  ];
}

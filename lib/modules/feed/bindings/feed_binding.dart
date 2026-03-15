import 'package:provider/provider.dart';
import '../controllers/feed_controller.dart';

class FeedBinding {
  static ChangeNotifierProvider<FeedController> provider() {
    return ChangeNotifierProvider(
      create: (_) => FeedController()..loadFeed(),
    );
  }
}

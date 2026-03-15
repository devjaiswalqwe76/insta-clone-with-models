import 'package:flutter/material.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/main/views/main_view.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.initial: (context) => const LoginView(),
      AppRoutes.login: (context) => const LoginView(),
      AppRoutes.feed: (context) => const MainView(),
    };
  }
}

// Packages
import 'package:flutter/cupertino.dart';
import 'package:products_app/feature/home/home_page.dart';
import 'package:products_app/feature/overlay/overlay_page.dart';
import 'package:products_app/main/navigation/route_paths.dart';

// Screens
import 'package:products_app/feature/splash/splash_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // *** Splash Route *** //
      case RoutePaths.splash:
        return CupertinoPageRoute(
          builder: (context) => SplashPage(),
          settings: const RouteSettings(name: RoutePaths.splash),
        );

      // *** Home Route *** //
      case RoutePaths.home:
        return CupertinoPageRoute(
          builder: (context) => HomePage(),
          settings: const RouteSettings(name: RoutePaths.home),
        );

      // *** Overlay Route *** //
      case RoutePaths.overlay:
        return CupertinoPageRoute(
          builder: (context) => OverlayPage(),
          settings: const RouteSettings(name: RoutePaths.overlay),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}

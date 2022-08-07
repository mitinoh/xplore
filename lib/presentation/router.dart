import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/home/sc_home.dart';
import 'package:xplore/presentation/screen/login/sc_login.dart';
import 'package:xplore/presentation/screen/search/sc_search.dart';
import 'package:xplore/presentation/screen/splash/sc_splash.dart';

class AppRouter {
  static const String HOME = '/home';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String SEARCH = '/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Navigator.pushNamed(context, AppRouter.LOGIN);
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SEARCH:
        return MaterialPageRoute(builder: (_) => SearchScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

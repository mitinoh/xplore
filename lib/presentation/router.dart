import 'package:flutter/material.dart';
import 'package:xplore/presentation/screen/home/sc_home.dart';
import 'package:xplore/presentation/screen/login/sc_login.dart';
import 'package:xplore/presentation/screen/map/screen/map_screen.dart';
import 'package:xplore/presentation/screen/new_location/new_location_screen.dart';
import 'package:xplore/presentation/screen/planner/sc_planner.dart';
import 'package:xplore/presentation/screen/search/sc_search.dart';
import 'package:xplore/presentation/screen/splash/sc_splash.dart';
import 'package:xplore/presentation/screen/user/sc_edit_profile.dart';
import 'package:xplore/presentation/screen/user/sc_user.dart';

class AppRouter {
  static const String HOME = '/home';
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String SEARCH = '/search';
  static const String USER = '/user';
  static const String EDITUSER = '/edituser';
  static const String PLANNER = '/planner';
  static const String NEWLOCATION = '/newlocation';
  static const String MAP = '/map';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = (settings.arguments ?? <String, dynamic>{}) as Map;
    // Navigator.pushNamed(context, AppRouter.LOGIN);
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case SPLASH:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case LOGIN:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SEARCH:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case USER:
        return MaterialPageRoute(builder: (_) => UserScreen());
      case PLANNER:
        return MaterialPageRoute(builder: (_) => PlannerScreen());
      case EDITUSER:
        return MaterialPageRoute(
            builder: (_) => EditProfileScreen(
                userData: arguments["user"], blocContext: arguments["context"]));
      case NEWLOCATION:
        return MaterialPageRoute(builder: (_) => NewLocation());
      case MAP:
        return MaterialPageRoute(builder: (_) => MapScreen());
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

import 'package:flutter/material.dart';
import 'package:xplore/presentation/common_widgets/widget_logo_findseat.dart';
import 'package:xplore/presentation/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData themex = Theme.of(context);
    return Scaffold(
      body: Container(
        color: themex.backgroundColor,
        child: Center(
          child: SizedBox(
            width: 240,
            child: WidgetLogoFindSeat(),
          ),
        ),
      ),
    );
  }

  void openLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRouter.LOGIN);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/app/simple_bloc_observer.dart';
import 'package:xplore/app_config.dart';
import 'package:xplore/presentation/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  App.initSystemDefault();
  BlocOverrides.runZoned(
    () => runApp(AppConfig(
      appName: "xplore",
      debugTag: false,
      flavorName: "prod",
      initialRoute: AppRouter.SPLASH,
      child: App.runWidget(),
    )),
    blocObserver: SimpleBlocObserver(),
  );
}

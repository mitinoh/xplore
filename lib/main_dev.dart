

import 'package:flutter/material.dart';
import 'package:xplore/app/app.dart';
import 'package:xplore/app_config.dart';
import 'package:xplore/presentation/router.dart';

void main() {
  App.initSystemDefault();

  runApp(
    AppConfig(
      appName: "FindSeat Dev",
      debugTag: true,
      flavorName: "dev",
      initialRoute: AppRouter.BOOK_SEAT_SLOT,
      child: App.runWidget(),
    ),
  );
}

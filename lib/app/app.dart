import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/app/simple_bloc_observer.dart';
import 'package:xplore/app_config.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/router.dart';
import 'package:xplore/presentation/screen/home/sc_home.dart';
import 'package:xplore/presentation/screen/login/sc_login.dart';
import 'package:xplore/presentation/screen/splash/sc_splash.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

import '../presentation/screen/home/bloc/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context)!;

    return MaterialApp(
      debugShowCheckedModeBanner: config.debugTag,
      theme: ThemeData(
        brightness: Brightness.light,
        //primaryColor: COLOR_CONST.DEFAULT,
        //hoverColor: COLOR_CONST.GREEN,
        fontFamily: 'Poppins',
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          } else if (state is Unauthenticated) {
            //return Text("login");
            return LoginScreen();
          } else if (state is Authenticated) {
            return HomeScreen();
            //   return HomeScreen();
          }

          return Container(
            child: Center(child: Text('Unhandle State $state')),
          );
        },
      ),
    );
  }

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: COLOR_CONST.STATUS_BAR,
      ),
    );
  }

  static Widget runWidget() {
    WidgetsFlutterBinding.ensureInitialized();

    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final UserRepository userRepository = UserRepository();
          final HomeRepository homeRepository = HomeRepository();
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<UserRepository>(
                  create: (context) => userRepository),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      AuthenticationBloc(userRepository: userRepository)
                        ..add(AppStarted()),
                ),
                BlocProvider(
                  create: (context) => HomeBloc(homeRepository: homeRepository),
                )
              ],
              child: App(),
            ),
          );
        }

        return Container();
      },
    );
  }
}

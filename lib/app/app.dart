import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/app_config.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/auth_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/navigation_bar.dart';
import 'package:xplore/presentation/router.dart';
import 'package:xplore/presentation/screen/home/sc_home.dart';
import 'package:xplore/presentation/screen/login/sc_login.dart';
import 'package:xplore/presentation/screen/search/bloc/search_location_bloc.dart';
import 'package:xplore/presentation/screen/splash/sc_splash.dart';
import 'package:xplore/presentation/screen/user/bloc/bloc.dart';
import 'package:xplore/presentation/screen/user/sc_user.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

import '../presentation/screen/home/bloc/bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();

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
          final AuthRepository authRepository = AuthRepository();
          final UserRepository userRepository = UserRepository();
          final HomeRepository homeRepository = HomeRepository();
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                  create: (context) => authRepository),
              RepositoryProvider<HomeRepository>(
                  create: (context) => homeRepository),
              RepositoryProvider<UserRepository>(
                  create: (context) => userRepository),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                        AuthenticationBloc(authRepository: authRepository)
                          ..add(AppStarted())),
                BlocProvider(
                    create: (context) =>
                        HomeBloc(homeRepository: homeRepository)),
                BlocProvider(
                    create: (context) =>
                        SearchLocationBloc(homeRepository: homeRepository)),
                BlocProvider(
                    create: (context) =>
                        UserBloc(userRepository: userRepository)),
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

class _AppState extends State<App> {
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
            return LoginScreen();
          } else if (state is Authenticated) {
            return Scaffold(
                bottomNavigationBar: NavigationBarWidget(
                    indexChange: (index) => changeIndex(index)),
                body: SafeArea(child: _routeOptions.elementAt(selectedIndex)));
            //   return HomeScreen();
          }

          return Container(
            child: Center(child: Text('Unhandle State $state')),
          );
        },
      ),
    );
  }

  int selectedIndex = 0;

  changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static List<Widget> _routeOptions = <Widget>[
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    UserScreen()
  ];
}

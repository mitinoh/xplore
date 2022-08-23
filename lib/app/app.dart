import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/app_config.dart';
import 'package:xplore/model/repository/follower_repository.dart';
import 'package:xplore/model/repository/home_repository.dart';
import 'package:xplore/model/repository/auth_repository.dart';
import 'package:xplore/model/repository/location_category_repository.dart';
import 'package:xplore/model/repository/planner_repository.dart';
import 'package:xplore/model/repository/report_repository.dart';
import 'package:xplore/model/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/navbar.dart';
import 'package:xplore/presentation/router.dart';
import 'package:xplore/presentation/screen/home/bloc_location_category/bloc.dart';
import 'package:xplore/presentation/screen/login/sc_login.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_future_trip/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_question/bloc.dart';
import 'package:xplore/presentation/screen/search/bloc/search_location_bloc.dart';
import 'package:xplore/presentation/screen/splash/sc_splash.dart';
import 'package:xplore/presentation/screen/user/bloc_follower/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_report/bloc.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';

import '../presentation/screen/home/bloc/bloc.dart';
import '../presentation/screen/planner/bloc_current_trip/bloc.dart';

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
          final FollowerRepository followerRepository = FollowerRepository();
          final ReportRepository reportRepository = ReportRepository();
          final PlannerRepository plannerRepository = PlannerRepository();
         final LocationCategoryRepository locationCategoryRepository = LocationCategoryRepository();
        
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(
                  create: (context) => authRepository),
              RepositoryProvider<HomeRepository>(
                  create: (context) => homeRepository),
              RepositoryProvider<UserRepository>(
                  create: (context) => userRepository),
              RepositoryProvider<FollowerRepository>(
                  create: (context) => followerRepository),
              RepositoryProvider<ReportRepository>(
                  create: (context) => reportRepository),
              RepositoryProvider<PlannerRepository>(
                  create: (context) => plannerRepository),
              RepositoryProvider<LocationCategoryRepository>(
                  create: (context) => locationCategoryRepository),

                  
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
                    create: (context) => SearchLocationBloc(
                        homeRepository: homeRepository,
                        userRepository: userRepository)),
                BlocProvider(
                    create: (context) =>
                        FollowerBloc(followerRepository: followerRepository)),
                BlocProvider(
                    create: (context) =>
                        ReportBloc(reportRepository: reportRepository)),
                BlocProvider(
                    create: (context) =>
                        PlannerBloc(plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) => CurrentPlannerBloc(
                        plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) =>
                        FuturePlannerBloc(plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) =>
                        PlannerQuestionBloc(plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) =>
                        LocationCategoryBloc(locationCategroyRepository: locationCategoryRepository))
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
              return Scaffold(body: Navbar());
              //   return HomeScreen();
            }

            return Container(
              child: Center(child: Text('Unhandle State $state')),
            );
          },
        ));
  }
}

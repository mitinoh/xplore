import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:xplore/app/auth_bloc/bloc.dart';
import 'package:xplore/app_config.dart';
import 'package:xplore/data/model/user_model.dart';
import 'package:xplore/data/repository/follower_repository.dart';
import 'package:xplore/data/repository/home_repository.dart';
import 'package:xplore/data/repository/auth_repository.dart';
import 'package:xplore/data/repository/location_category_repository.dart';
import 'package:xplore/data/repository/planner_repository.dart';
import 'package:xplore/data/repository/report_repository.dart';
import 'package:xplore/data/repository/user_repository.dart';
import 'package:xplore/presentation/common_widgets/navbar.dart';
import 'package:xplore/presentation/common_widgets/wg_error.dart';
import 'package:xplore/presentation/router.dart';
import 'package:xplore/presentation/screen/home/bloc_location_category/bloc.dart';
import 'package:xplore/presentation/screen/login/sc_login.dart';
import 'package:xplore/presentation/screen/map/bloc_map/bloc.dart';
import 'package:xplore/presentation/screen/map/bloc_user_position/bloc.dart';
import 'package:xplore/presentation/screen/new_location/bloc/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc/bloc.dart';
import 'package:xplore/presentation/screen/planner/bloc_future_trip/bloc.dart';
import 'package:xplore/presentation/screen/search/bloc/search_location_bloc.dart';
import 'package:xplore/presentation/screen/splash/sc_splash.dart';
import 'package:xplore/presentation/screen/user/bloc_follower/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_report/bloc.dart';
import 'package:xplore/presentation/screen/user/bloc_user/user_bloc.dart';
import 'package:xplore/presentation/screen/user/sc_edit_profile.dart';
import 'package:xplore/utils/const/COLOR_CONST.dart';
import 'package:xplore/utils/theme.dart';

import '../presentation/screen/home/bloc/bloc.dart';
import '../presentation/screen/planner/bloc_current_trip/bloc.dart';
import '../presentation/screen/user/bloc_user/bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();

  static void initSystemDefault() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: COLOR_CONST.DEFAULT100));
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
          final LocationCategoryRepository locationCategoryRepository =
              LocationCategoryRepository();

          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider<AuthRepository>(create: (context) => authRepository),
              RepositoryProvider<HomeRepository>(create: (context) => homeRepository),
              RepositoryProvider<UserRepository>(create: (context) => userRepository),
              RepositoryProvider<FollowerRepository>(
                  create: (context) => followerRepository),
              RepositoryProvider<ReportRepository>(create: (context) => reportRepository),
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
                    create: (context) => HomeBloc(homeRepository: homeRepository)),
                BlocProvider(
                    create: (context) => SearchLocationBloc(
                        homeRepository: homeRepository, userRepository: userRepository)),
                BlocProvider(
                    create: (context) =>
                        FollowerBloc(followerRepository: followerRepository)),
                BlocProvider(
                    create: (context) => ReportBloc(reportRepository: reportRepository)),
                BlocProvider(
                    create: (context) =>
                        PlannerBloc(plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) =>
                        CurrentPlannerBloc(plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) =>
                        FuturePlannerBloc(plannerRepository: plannerRepository)),
                BlocProvider(
                    create: (context) =>
                        UserPositionBloc(userRepository: userRepository)),
                BlocProvider(
                    create: (context) =>
                        NewLocationBloc(locationRepository: homeRepository)),
                BlocProvider(
                    create: (context) => MapBloc(locationRepository: homeRepository)),
                BlocProvider(
                    create: (context) => UserBloc(userRepository: userRepository)),
                /*  BlocProvider(
                    create: (context) =>
                        PlannerQuestionBloc(plannerRepository: plannerRepository)),
                        */
                BlocProvider(
                    create: (context) => LocationCategoryBloc(
                        locationCategroyRepository: locationCategoryRepository))
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
        theme: ThemeX.lightTheme,
        darkTheme: ThemeX.darkTheme, // standard dark theme
        themeMode: ThemeMode.system, // device controls theme
        onGenerateRoute: AppRouter.generateRoute,
        home: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserDataLoaded) {
              //  Navigator.pop(context);
              context.read<AuthenticationBloc>().add(LoggedIn());
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (ct, state) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return ErrorScreen(errorDetails: errorDetails);
              };

              if (state is Uninitialized) {
                return SplashScreen();
              } else if (state is Unauthenticated) {
                return LoginScreen();
              } else if (state is Authenticated) {
                return Scaffold(body: Navbar());
                //   return HomeScreen();
              } else if (state is AuthenticatedNewUser) {
                return EditProfileScreen(
                  userData: UserModel(),
                  blocContext: context,
                  newUser: true,
                  callback: (UserModel userData) {
                    context.read<UserBloc>()..add(CreateNewUser(userData: userData));
                  },
                );
              } else {
                return ErrorScreen(
                  state: state,
                );
              }
            },
          ),
        ));
  }
}

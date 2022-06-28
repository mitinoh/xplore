import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:xplore/app/auth/bloc/auth_bloc.dart';
import 'package:xplore/app/auth/repository/auth_repository.dart';
import 'package:xplore/app/auth/screen/sign_in.dart';
import 'package:xplore/app/home/screen/home_screen.dart';
import 'package:xplore/core/globals.dart';
import 'package:xplore/core/widgets/navbar.dart';

import 'core/theme.dart';

void main() async {
  /*
  const fetchBackground = "fetchBackground";

  void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case fetchBackground:
          Position userLocation = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);

          log("fetchBackground" + userLocation.toString());

          noti.Notification notification = new noti.Notification();
          notification.showNotificationWithoutSound(userLocation);
          break;
      }
      return Future.value(true);
    });
  }

Workmanager().registerOneOffTask(
  "1", // Ignored on iOS
  fetchBackground, // Ignored on iOS
  initialDelay: Duration(minutes: 15),
  constraints: Constraints(
    // connected or metered mark the task as requiring internet
    networkType: NetworkType.connected,
    // require external power
    requiresCharging: true,
  )
);

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
*/

  // keytool -genkey -v -keystore ~/.android/debug.keystore -storepass android -alias androiddebugkey -keypass android -dname "CN=Android Debug,O=Android,C=US"
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  await Firebase.initializeApp();

/*
  Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: Duration(minutes: 15),
  );*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          // scaffoldMessengerKey: snackbarKey, // REVIEW:
          /* localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('it', ''), // Spanish, no country code
          ],
          */
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/home': (context) => const HomePage(),
            '/app': (context) => Navbar()
          },
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, state) {
                // If the snapshot has user data, then they're already signed in. So Navigating to the Dashboard.

                // return Text(AppLocalizations.of(context)!.helloWorld);
                
                if ((state.hasData)) {
                  if (BlocProvider.of<AuthBloc>(context).state
                      is! NewUserAuthenticated) return Navbar();
                }
                // Otherwise, they're not signed in. Show the sign in page.
                return const SignIn();
              }),
        ),
      ),
    );
  }
}

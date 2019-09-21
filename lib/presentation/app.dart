import 'package:app/presentation/pages/challenge/View.dart';
import 'package:app/presentation/pages/create-post/View.dart';
import 'package:app/presentation/pages/edit-profile/View.dart';
import 'package:app/presentation/pages/home/View.dart';
import 'package:app/presentation/pages/login/View.dart';
import 'package:app/presentation/pages/splash/View.dart';
import 'package:app/presentation/pages/training-filter/View.dart';
import 'package:app/presentation/pages/training/View.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/navigator/RouteObserver.dart';
import 'package:app/presentation/state/navigator/routes/MainRoute.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final analytics = FirebaseAnalytics();

class MyApp extends StatelessWidget {

//  final Store store;

  const MyApp({Key key}) : super(key: key);


  MaterialPageRoute _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MainRoute(LoginPage(), settings: settings);
      case AppRoutes.home:
        return MainRoute(HomePage(), settings: settings);
      case AppRoutes.editProfile:
        return MainRoute(EditProfilePage(), settings: settings);
      case AppRoutes.createPost:
        return MainRoute(CreatePostPage(), settings: settings);
      case AppRoutes.challenge:
        return MainRoute(ChallengePage(), settings: settings);
      case AppRoutes.trainingFilter:
        return MainRoute(TrainingFilterPage(), settings: settings);
      case AppRoutes.training:
        return MainRoute(TrainingPage(), settings: settings);
      default:
        return MainRoute(SplashPage(), settings: settings);
    }
  }


  @override
  Widget build(BuildContext context) {
    final analytics = FirebaseAnalytics();
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Liceu',
          theme: ThemeData(
              primaryColorDark: Colors.black, primaryColor: Colors.black),
          navigatorKey: navigatorKey,
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) => _getRoute(settings),
        ));
  }
}

class AppRoutes {
  static const splash = "/";
  static const home = "/home";
  static const editProfile = "/editProfile";
  static const createPost = "/createPost";
  static const challenge = "/challenge";
  static const trainingFilter = "/trainingFilter";
  static const training = "/training";
  static const login = "/login";
}

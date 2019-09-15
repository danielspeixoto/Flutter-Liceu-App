import 'package:app/presentation/pages/create-post/View.dart';
import 'package:app/presentation/pages/edit-profile/View.dart';
import 'package:app/presentation/pages/home/View.dart';
import 'package:app/presentation/pages/login/View.dart';
import 'package:app/presentation/pages/splash/View.dart';
import 'package:app/presentation/redux/navigator/RouteObserver.dart';
import 'package:app/presentation/redux/navigator/routes/MainRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  final Store store;

  const MyApp({Key key, this.store}) : super(key: key);


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
      default:
        return MainRoute(SplashPage(), settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) => StoreProvider(
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

class AppRoutes {
  static const splash = "/";
  static const home = "/home";
  static const editProfile = "/editProfile";
  static const createPost = "/createPost";
  static const login = "/login";
}

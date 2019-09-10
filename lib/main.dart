import 'package:app/presentation/navigator/NavigatorMiddleware.dart';
import 'package:app/presentation/navigator/RouteObserver.dart';
import 'package:app/presentation/navigator/routes/MainRoute.dart';
import 'package:app/presentation/pages/create-post/View.dart';
import 'package:app/presentation/pages/home/View.dart';
import 'package:app/presentation/pages/login/View.dart';
import 'package:app/presentation/pages/splash/View.dart';
import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'Injection.dart';
import 'State.dart';
import 'package:redux_logging/redux_logging.dart';

void main() => runApp(MyApp());

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [
        new LoggingMiddleware.printer(),
        UserPresenter(myInfoUseCase, isLoggedInUseCase, myPostsUseCase),
        ...navigationMiddleware()
      ]);

  MaterialPageRoute _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MainRoute(SplashPage(), settings: settings);
      case AppRoutes.home:
        return MainRoute(HomePage(), settings: settings);
      case AppRoutes.createPost:
        return MainRoute(CreatePostPage(), settings: settings);
      default:
        return MainRoute(LoginPage(), settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) => StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Liceu',
        theme: ThemeData(
            primaryColorDark: new Color(0xFF0061A1),
            primaryColor: new Color(0xFF0061A1)
        ),
        navigatorKey: navigatorKey,
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) => _getRoute(settings),
      ));
}

class AppRoutes {
  static const splash = "/";
  static const home = "/home";
  static const createPost = "/createPost";
  static const login = "/login";
}

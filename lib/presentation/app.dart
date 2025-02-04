import 'package:app/presentation/pages/challenge/View.dart';
import 'package:app/presentation/pages/create-post/View.dart';
import 'package:app/presentation/pages/create-trivia/View.dart';
import 'package:app/presentation/pages/edit-profile/View.dart';
import 'package:app/presentation/pages/home/View.dart';
import 'package:app/presentation/pages/image-post/View.dart';
import 'package:app/presentation/pages/intro/View.dart';
import 'package:app/presentation/pages/login/View.dart';
import 'package:app/presentation/pages/complete-post/View.dart';
import 'package:app/presentation/pages/saved-posts/View.dart';
import 'package:app/presentation/pages/splash/View.dart';
import 'package:app/presentation/pages/tournament-review/View.dart';
import 'package:app/presentation/pages/tournament/View.dart';
import 'package:app/presentation/pages/training-filter/View.dart';
import 'package:app/presentation/pages/training/View.dart';
import 'package:app/presentation/pages/friend/View.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/navigator/RouteObserver.dart';
import 'package:app/presentation/state/navigator/routes/MainRoute.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'background/FirebaseNotifications.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
final analytics = FirebaseAnalytics();

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key) {
    ExternalConnections(store);
  }

  MaterialPageRoute _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MainRoute(LoginPage(), settings: settings);
      case AppRoutes.home:
        return MainRoute(HomePage(), settings: settings);
      case AppRoutes.friend:
        return MainRoute(FriendPage(), settings: settings);
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
      case AppRoutes.tournament:
        return MainRoute(TournamentPage(), settings: settings);
      case AppRoutes.tournamentReview:
        return MainRoute(TournamentReviewPage(), settings: settings);
      case AppRoutes.createTrivia:
        return MainRoute(CreateTriviaPage(), settings: settings);
      case AppRoutes.intro:
        return MainRoute(IntroPage(), settings: settings);
      case AppRoutes.completePost:
        return MainRoute(CompletePostPage(), settings: settings);
      case AppRoutes.imagePost:
        return MainRoute(ImagePostPage(), settings: settings);
      case AppRoutes.savedPosts:
        return MainRoute(SavedPostsPage(), settings: settings);
      default:
        return MainRoute(SplashPage(), settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Liceu',
          theme: ThemeData(
            primaryColorDark: Colors.black54,
            primaryColor: Colors.white,
            accentColor: Color(0xFF0061A1),
          ),
          navigatorKey: navigatorKey,
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) => _getRoute(settings),
        ));
  }
}

class AppRoutes {
  static const splash = "/";
  static const intro = "/intro";
  static const home = "/home";
  static const editProfile = "/editProfile";
  static const createPost = "/createPost";
  static const challenge = "/challenge";
  static const trainingFilter = "/trainingFilter";
  static const training = "/training";
  static const tournament = "/tournament";
  static const tournamentReview = "/tournamentReview";
  static const login = "/login";
  static const friend = "/friend";
  static const createTrivia = "/createTrivia";
  static const completePost = "/completePost";
  static const imagePost = "/imagePost";
  static const savedPosts = "/savedPosts";
}

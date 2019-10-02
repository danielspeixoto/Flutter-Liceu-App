import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/NotificationActions.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_state.dart';

List<Middleware<AppState>> notificationMiddleware(
  IIsLoggedInUseCase _isLoggedInUseCase,
) {
  void handleNotification(Store<AppState> store, String action, Map data) {
    switch (action) {
      case "start_challenge":
        store.dispatch(PlayRandomChallengeAction());
        break;
      case "enem_training":
        store.dispatch(StartTrainingAction());
        break;
      case "enem_tournament":
        store.dispatch(StartTournamentAction());
        break;
      case "webpage":
        if (data.containsKey("url")) {
          launch(data["url"]);
        }
        break;
      case "answer_challenge":
        if (data.containsKey("challengeId")) {
          store.dispatch(AcceptChallengeAction(data["challengeId"]));
        }
    }
  }

  void resume(Store<AppState> store, NotificationResumesApp action,
      NextDispatcher next) async {
    next(action);
    if (store.state.loginState.isUserLoggedIn()) {
      handleNotification(store, action.action, action.data);
    }
  }

  void launchNotification(Store<AppState> store, NotificationLaunchesApp action,
      NextDispatcher next) async {
    next(action);
    try {
      await Future.delayed(Duration(seconds: 1));
      if (store.state.loginState.isUserLoggedIn()) {
        handleNotification(store, action.action, action.data);
      }
    } catch (e) {
      print(e);
      store.dispatch(PageActionErrorAction(action.toString().substring(11)));
    }
  }

  return [
    TypedMiddleware<AppState, NotificationResumesApp>(resume),
    TypedMiddleware<AppState, NotificationLaunchesApp>(launchNotification),
  ];
}
